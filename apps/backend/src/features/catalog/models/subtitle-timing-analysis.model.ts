export type SubtitleTimingAnalysis = {
  detectedOffsetMs: number;
  confidence: number; // 0-100
  appliedCorrection: boolean;
  warnings: string[];
};
