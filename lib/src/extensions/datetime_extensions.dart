part of 'extensions.dart';

extension DateTimeExtensions on DateTime {
  /// Calculates the time difference between the given date and the current time,
  /// returning results in various formats:
  /// - now
  /// - 30 min ago / 3min
  /// - 4 hours ago / 4h
  /// - 2 days ago / 2d
  /// - 1 month ago / 1m
  String passingTime(DateTime? datetime,
      {bool turkish = false, bool short = false}) {
    if (datetime == null) {
      return " - "; // Returns a placeholder if the provided date is null
    }

    final now = DateTime.now(); // Get the current time
    final differenceTime =
        now.difference(datetime); // Calculate the time difference
    final isPast = differenceTime.isNegative
        ? false
        : true; // Check if the time is in the past
    final absDifference = differenceTime.abs(); // Get the absolute difference

    String result = "";

    if (absDifference.inMinutes < 1) {
      return turkish
          ? "şimdi"
          : "now"; // Return 'now' if less than a minute has passed
    } else if (absDifference.inMinutes < 60) {
      final minutes = absDifference.inMinutes;
      result =
          "$minutes ${turkish ? 'dakika' : (short ? 'min' : minutes > 1 ? 'minutes' : 'minute')}";
    } else if (absDifference.inHours < 24) {
      final hours = absDifference.inHours;
      result =
          "$hours ${turkish ? 'saat' : (short ? 'h' : hours > 1 ? 'hours' : 'hour')}";
    } else if (absDifference.inDays < 30) {
      final days = absDifference.inDays;
      result =
          "$days ${turkish ? 'gün' : (short ? 'd' : days > 1 ? 'days' : 'day')}";
    } else {
      final months =
          (absDifference.inDays / 30).floor(); // Calculate the number of months
      result =
          "$months ${turkish ? 'ay' : (short ? 'm' : months > 1 ? 'months' : 'month')}";
    }

    if (short) {
      return result.replaceAll(
          " ", ""); // Return the result if short format is requested
    } else {
      if (isPast) {
        return turkish
            ? "$result önce"
            : "$result ago"; // Return past time format
      } else {
        return turkish
            ? "$result içinde"
            : "in $result"; // Return future time format
      }
    }
  }
}
