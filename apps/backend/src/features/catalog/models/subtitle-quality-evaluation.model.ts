export type SubtitleConfidenceLevel = 'high' | 'medium' | 'low';

export type SubtitleQualityEvaluation = {
  confidenceScore: number; // 0-100
  confidenceLevel: SubtitleConfidenceLevel;
  warnings: string[];
  shouldBlockAutoUse: boolean;
  /**
   * Internal-only structured signals used to build the deterministic score.
   * Do not expose this to clients.
   */
  signals: Record<string, unknown>;
};
