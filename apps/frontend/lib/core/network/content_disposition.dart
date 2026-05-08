String? extractFileNameFromContentDisposition(String? rawValue) {
  if (rawValue == null || rawValue.trim().isEmpty) {
    return null;
  }

  final match = RegExp(
    "filename\\*?=(?:UTF-8'')?\"?([^\";]+)\"?",
    caseSensitive: false,
  ).firstMatch(rawValue);

  if (match == null) {
    return null;
  }

  return Uri.decodeComponent(match.group(1)!.trim());
}
