import { SubtitleSourceCandidate } from 'features/catalog/models/subtitle-source-candidate.model';

const normalizeUrl = (value: string): string => value.trim().toLowerCase();

export const dedupeSubtitleSourceCandidates = (
  candidates: SubtitleSourceCandidate[],
): SubtitleSourceCandidate[] => {
  const deduped = new Map<string, SubtitleSourceCandidate>();

  for (const candidate of candidates) {
    const primaryKey = `${candidate.provider}:${candidate.providerSubtitleId}`;
    const fallbackKey = `${candidate.provider}:${normalizeUrl(candidate.sourcePageUrl)}`;
    const key =
      candidate.providerSubtitleId.trim().length > 0 ? primaryKey : fallbackKey;
    const existing = deduped.get(key);

    if (!existing || existing.score < candidate.score) {
      deduped.set(key, candidate);
    }
  }

  return [...deduped.values()];
};
