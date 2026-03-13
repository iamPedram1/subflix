import { SubtitleFormat } from 'src/common/domain/enums/subtitle-format.enum';

export type CatalogSubtitleSource = {
  id: string;
  label: string;
  releaseGroup: string;
  format: SubtitleFormat;
  hearingImpaired: boolean;
  lineCount: number;
  downloads: number;
  rating: number;
};
