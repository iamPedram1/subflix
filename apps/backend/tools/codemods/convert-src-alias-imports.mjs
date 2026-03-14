import fs from 'node:fs';
import path from 'node:path';
import ts from 'typescript';

const repoRoot = process.cwd();

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

const rewriteSpecifier = (specifier) => {
  if (!specifier.startsWith('src/')) {
    return null;
  }

  if (specifier.startsWith('src/common/')) {
    return `common/${specifier.slice('src/common/'.length)}`;
  }

  if (specifier.startsWith('src/features/')) {
    return `features/${specifier.slice('src/features/'.length)}`;
  }

  // Default: drop the leading "src/" for app root files (e.g. app.module).
  return specifier.slice('src/'.length);
};

const rewriteFile = (filePath) => {
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

    const next = rewriteSpecifier(literal.text);
    if (!next || next === literal.text) {
      return;
    }

    const start = literal.getStart(sourceFile) + 1;
    const end = literal.getEnd() - 1;
    replacements.push({ start, end, value: next });
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

const targets = [path.join(repoRoot, 'src'), path.join(repoRoot, 'test')];
const files = targets.flatMap(listTsFiles);
let changed = 0;

for (const file of files) {
  if (rewriteFile(file)) {
    changed += 1;
  }
}

// eslint-disable-next-line no-console
console.log(JSON.stringify({ scanned: files.length, changed }, null, 2));

