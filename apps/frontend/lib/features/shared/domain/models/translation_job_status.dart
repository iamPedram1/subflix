enum TranslationJobStatus {
  queued('Queued'),
  translating('Translating'),
  completed('Completed'),
  failed('Failed');

  const TranslationJobStatus(this.label);

  final String label;
}
