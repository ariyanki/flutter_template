import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class TimeHelper {
  static formatDate(DateTime dateTime,
      [String format = 'dd/MM/yyyy HH:mm WIB', int utc = 7]) {
    return DateFormat(format).format(dateTime.add(Duration(hours: utc)));
  }

  static formatDateTimeString(
    String? dateTimeString, {
    String format = 'dd/MM/yyyy HH:mm WIB',
    int utc = 7,
  }) {
    if (dateTimeString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateTimeString);
      return DateFormat(format).format(date.add(Duration(hours: utc)));
    } catch (_) {
      return dateTimeString;
    }
  }

  static formatDateString(String? dateTimeString,
          [String format = 'dd/MM/yyyy HH:mm WIB']) =>
      formatDateTimeString(dateTimeString, format: format);

  static formatLocalTimeToServerTime(DateTime dateTime) =>
      formatDate(dateTime, 'yyyy-MM-ddTHH:mm:ss', -7);

  static formatLocalTimeToServerTimeEndDate(DateTime dateTime, [int utc = 7]) =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').format(
        dateTime.add(
          Duration(hours: 23 - utc, minutes: 59, seconds: 59),
        ),
      );

  static formatDateTimeFilterFrom(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.add(const Duration(hours: -7)).toIso8601String();
  }

  static formatDateTimeFilterTo(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.add(const Duration(hours: 17)).toIso8601String();
  }

  static isAfterSixMonth(DateTime dateTime) {
    return Jiffy(DateTime.now()).isAfter(Jiffy(dateTime).add(months: 6));
  }

  static isAfterMinutes(DateTime dateTime, int minute) {
    return Jiffy(DateTime.now()).isAfter(Jiffy(dateTime).add(minutes: minute));
  }
}
