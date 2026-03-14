import fs from 'node:fs';
import path from 'node:path';
import ts from 'typescript';

const repoRoot = process.cwd();
const srcRoot = path.join(repoRoot, 'src');
const testRoot = path.join(repoRoot, 'test');

const isUnder = (root, filePath) => {
  const rel = path.relative(root, filePath);
  return !!rel && !rel.startsWith('..') && !path.isAbsolute(rel);
};

const toPosix = (value) => value.split(path.sep).join('/');

const resolveTargetFile = (basePath) => {
  const candidates = [
    basePath,
    `${basePath}.ts`,
    `${basePath}.tsx`,
    path.join(basePath, 'index.ts'),
    path.join(basePath, 'index.tsx'),
  ];

  for (const candidate of candidates) {
    try {
      const stat = fs.statSync(candidate);
      if (stat.isFile()) {
        return candidate;
      }
    } catch {
      // ignore
    }
  }

  return null;
};

const computeAbsoluteSpecifier = (fromFile, relativeSpecifier) => {
  const fromDir = path.dirname(fromFile);
  const resolvedBase = path.resolve(fromDir, relativeSpecifier);
  const resolvedFile = resolveTargetFile(resolvedBase);
  if (!resolvedFile) {
    return null;
  }

  // Convert resolved file path to a project-root specifier using existing tsconfig paths.
  if (isUnder(srcRoot, resolvedFile)) {
    const rel = path.relative(repoRoot, resolvedFile);
    return toPosix(rel).replace(/\.(ts|tsx)$/, '');
  }

  if (isUnder(testRoot, resolvedFile)) {
    const rel = path.relative(repoRoot, resolvedFile);
    return toPosix(rel).replace(/\.(ts|tsx)$/, '');
  }

  return null;
};

const rewriteSourceFile = (filePath) => {
  const sourceText = fs.readFileSync(filePath, 'utf8');
  const sourceFile = ts.createSourceFile(
    filePath,
    sourceText,
    ts.ScriptTarget.ES2022,
    true,
    ts.ScriptKind.TS,
  );

  const replacements = [];

  const consider = (literal) => {
    if (!literal || !ts.isStringLiteral(literal)) {
      return;
    }

    const spec = literal.text;
    if (!spec.startsWith('.')) {
      return;
    }

    const abs = computeAbsoluteSpecifier(filePath, spec);
    if (!abs) {
      return;
    }

    // Replace only the inner string content (without quotes).
    const start = literal.getStart(sourceFile) + 1;
    const end = literal.getEnd() - 1;
    replacements.push({ start, end, value: abs });
  };

  const visit = (node) => {
    if (ts.isImportDeclaration(node)) {
      consider(node.moduleSpecifier);
    } else if (ts.isExportDeclaration(node)) {
      if (node.moduleSpecifier) {
        consider(node.moduleSpecifier);
      }
    }

    ts.forEachChild(node, visit);
  };

  visit(sourceFile);

  if (replacements.length === 0) {
    return false;
  }

  // Apply from the end so indices remain stable.
  replacements.sort((a, b) => b.start - a.start);
  let out = sourceText;
  for (const rep of replacements) {
    out = out.slice(0, rep.start) + rep.value + out.slice(rep.end);
  }

  if (out !== sourceText) {
    fs.writeFileSync(filePath, out, 'utf8');
    return true;
  }

  return false;
};

const listTsFiles = (rootDir) => {
  const results = [];
  const stack = [rootDir];

  while (stack.length > 0) {
    const dir = stack.pop();
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    for (const entry of entries) {
      if (entry.name === 'node_modules' || entry.name === 'dist') {
        continue;
      }

      const fullPath = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        stack.push(fullPath);
        continue;
      }

      if (entry.isFile() && entry.name.endsWith('.ts')) {
        results.push(fullPath);
      }
    }
  }

  return results;
};

const files = listTsFiles(srcRoot);
let changed = 0;
let unresolved = 0;

for (const file of files) {
  const before = fs.readFileSync(file, 'utf8');
  const didChange = rewriteSourceFile(file);
  if (didChange) {
    changed += 1;
  }

  // Quick sanity: warn if there are still relative specifiers after rewrite.
  const after = didChange ? fs.readFileSync(file, 'utf8') : before;
  if (/\bfrom\s+['"]\.\.?\//.test(after) || /\bexport\s+\*\s+from\s+['"]\.\.?\//.test(after)) {
    unresolved += 1;
    // eslint-disable-next-line no-console
    console.warn(`[warn] still has relative imports: ${path.relative(repoRoot, file)}`);
  }
}

// eslint-disable-next-line no-console
console.log(
  JSON.stringify(
    { scanned: files.length, changed, stillHasRelativeImports: unresolved },
    null,
    2,
  ),
);

