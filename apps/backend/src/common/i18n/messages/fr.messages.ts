import type { I18nMessageCatalog } from 'common/i18n/i18n.types';

export const FR_MESSAGES: I18nMessageCatalog = {
  'errors.internal_error': "Une erreur inattendue s'est produite.",
  'errors.http_error': "Une erreur HTTP inattendue s'est produite.",
  'errors.payload_too_large':
    "Le fichier de sous-titres dépasse la limite d'envoi.",
  'errors.upload_invalid': 'Le fichier de sous-titres envoyé est invalide.',
  'errors.rate_limited': 'Trop de requêtes. Veuillez réessayer plus tard.',
  'errors.db.unique_constraint': "Une contrainte d'unicité a été violée.",
  'errors.db.invalid_reference':
    'Une référence à un enregistrement lié est invalide.',
  'errors.subtitles.file_required': 'Un fichier de sous-titres est requis.',
  'errors.subtitles.upload_limit_exceeded':
    "Le fichier de sous-titres dépasse la limite d'envoi.",
  'errors.subtitles.no_valid_cues':
    'Le fichier de sous-titres ne contient pas de repères valides.',
  'errors.subtitles.invalid_timestamp':
    'Horodatage de sous-titres invalide : {value}',
  'errors.subtitles.unsupported_file_type':
    'Type de fichier non pris en charge. Seuls les fichiers .srt et .vtt sont acceptés.',
  'errors.catalog.invalid_media_id':
    "L'identifiant demandé pour le média du catalogue est invalide.",
  'errors.catalog.not_found': "Le titre demandé n'a pas été trouvé.",
  'errors.catalog.subtitles_unavailable':
    'Les sources de sous-titres sont temporairement indisponibles pour ce titre.',
  'errors.catalog.tv_only_episode_scope':
    'seasonNumber et episodeNumber ne sont pris en charge que pour les titres TV.',
  'errors.translation.export_requires_completion':
    'Seuls les travaux de traduction terminés peuvent être exportés.',
  'errors.translation.missing_upload_reference':
    'parsedFileId est requis pour les traductions de sous-titres importés.',
  'errors.translation.missing_catalog_reference':
    'mediaId et subtitleSourceId sont requis pour les traductions du catalogue.',
  'errors.translation.media_not_found': "Le média demandé n'a pas été trouvé.",
  'errors.translation.subtitle_source_not_found':
    'La source de sous-titres demandée est introuvable.',
};
