import 'package:intl/intl.dart';

String getDateString(DateTime? date) {
  if (date == null) return '';
  return DateFormat('dd MMMM yyyy - HH:mm', 'en_US').format(date);
}
