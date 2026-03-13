import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toJobTimestamp() => DateFormat('MMM d, yyyy • h:mm a').format(this);
}
