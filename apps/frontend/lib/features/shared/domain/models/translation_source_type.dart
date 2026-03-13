enum TranslationSourceType {
  catalog('Auto-fetched subtitle'),
  upload('Uploaded file');

  const TranslationSourceType(this.label);

  final String label;
}
