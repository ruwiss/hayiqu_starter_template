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

extension DateTimeFormattingExtensions on DateTime {
  /// e.g., "6"
  String get day => DateFormat('d').format(this);

  /// e.g., "Thu"
  String get abbrWeekday => DateFormat('E').format(this);

  /// e.g., "Thursday"
  String get weekday => DateFormat('EEEE').format(this);

  /// e.g., "Jun"
  String get abbrStandaloneMonth => DateFormat('LLL').format(this);

  /// e.g., "June"
  String get standaloneMonth => DateFormat('LLLL').format(this);

  /// e.g., "6"
  String get numMonth => DateFormat('M').format(this);

  /// e.g., "6/6"
  String get numMonthDay => DateFormat('Md').format(this);

  /// e.g., "Thu, 6/6"
  String get numMonthWeekdayDay => DateFormat('MEd').format(this);

  /// e.g., "Jun"
  String get abbrMonth => DateFormat('MMM').format(this);

  /// e.g., "Jun 6"
  String get abbrMonthDay => DateFormat('MMMd').format(this);

  /// e.g., "Thu, Jun 6"
  String get abbrMonthWeekdayDay => DateFormat('MMMEd').format(this);

  /// e.g., "June"
  String get month => DateFormat('MMMM').format(this);

  /// e.g., "June 6"
  String get monthDay => DateFormat('MMMMd').format(this);

  /// e.g., "Thursday, June 6"
  String get monthWeekdayDay => DateFormat('MMMMEEEEd').format(this);

  /// e.g., "Q2"
  String get abbrQuarter => DateFormat('QQQ').format(this);

  /// e.g., "2nd quarter"
  String get quarter => DateFormat('QQQQ').format(this);

  /// e.g., "2024"
  String get year => DateFormat('y').format(this);

  /// e.g., "6/2024"
  String get yearNumMonth => DateFormat('yM').format(this);

  /// e.g., "6/6/2024"
  String get yearNumMonthDay => DateFormat('yMd').format(this);

  /// e.g., "Thu, 6/6/2024"
  String get yearNumMonthWeekdayDay => DateFormat('yMEd').format(this);

  /// e.g., "Jun 2024"
  String get yearAbbrMonth => DateFormat('yMMM').format(this);

  /// e.g., "Jun 6, 2024"
  String get yearAbbrMonthDay => DateFormat('yMMMd').format(this);

  /// e.g., "Thu, Jun 6, 2024"
  String get yearAbbrMonthWeekdayDay => DateFormat('yMMMEd').format(this);

  /// e.g., "June 2024"
  String get yearMonth => DateFormat('yMMMM').format(this);

  /// e.g., "June 6, 2024"
  String get yearMonthDay => DateFormat('yMMMMd').format(this);

  /// e.g., "Thursday, June 6, 2024"
  String get yearMonthWeekdayDay => DateFormat('yMMMMEEEEd').format(this);

  /// e.g., "Q2 2024"
  String get yearAbbrQuarter => DateFormat('yQQQ').format(this);

  /// e.g., "2nd quarter 2024"
  String get yearQuarter => DateFormat('yQQQQ').format(this);

  /// e.g., "14"
  String get hour24 => DateFormat('H').format(this);

  /// e.g., "14:30"
  String get hour24Minute => DateFormat('Hm').format(this);

  /// e.g., "14:30:45"
  String get hour24MinuteSecond => DateFormat('Hms').format(this);

  /// e.g., "2 PM"
  String get hour => DateFormat('j').format(this);

  /// e.g., "2:30 PM"
  String get hourMinute => DateFormat('jm').format(this);

  /// e.g., "2:30:45 PM"
  String get hourMinuteSecond => DateFormat('jms').format(this);

  /// e.g., "30"
  String get minute => DateFormat('m').format(this);

  /// e.g., "30:45"
  String get minuteSecond => DateFormat('ms').format(this);

  /// e.g., "45"
  String get second => DateFormat('s').format(this);

  /// e.g., "06/06/2024"
  String get mmddyyyy => DateFormat('MM/dd/yyyy').format(this);

  /// e.g., "06/06/2024"
  String get ddmmyyyy => DateFormat('dd/MM/yyyy').format(this);

  /// e.g., "2024-06-06"
  String get yyyymmdd => DateFormat('yyyy-MM-dd').format(this);

  /// e.g., "Thursday, June 6, 2024"
  String get fullDate => DateFormat('EEEE, MMMM d, yyyy').format(this);

  /// e.g., "June 6, 2024"
  String get monthDayYear => DateFormat('MMMM d, yyyy').format(this);

  /// e.g., "Jun 6, 2024"
  String get monthAbbrDayYear => DateFormat('MMM d, yyyy').format(this);

  /// e.g., "6/6/24"
  String get shortDate => DateFormat('M/d/yy').format(this);

  /// e.g., "2024-06-06T14:30:45"
  String get iso8601 => DateFormat('yyyy-MM-ddTHH:mm:ss').format(this);

  /// Helper method to get day with ordinal suffix (e.g., 1st, 2nd, 3rd)
  /// e.g., "6th"
  String get dayWithSuffix {
    int dayNum = this.day;
    String suffix;

    if (dayNum >= 11 && dayNum <= 13) {
      suffix = 'th';
    } else {
      switch (dayNum % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }
    return '$dayNum$suffix';
  }

  /// Format: June 6th, 2024
  String get monthDaySuffixYear {
    String month = DateFormat('MMMM').format(this); // e.g., "June"
    String daySuffix = dayWithSuffix; // e.g., "6th"
    String year = DateFormat('yyyy').format(this); // e.g., "2024"
    return '$month $daySuffix, $year'; // e.g., "June 6th, 2024"
  }

  /// e.g., "02:30 PM"
  String get hourMinuteAmPm => DateFormat('hh:mm a').format(this);

  /// e.g., "02:30:45 PM"
  String get hourMinuteSecondAmPm => DateFormat('hh:mm:ss a').format(this);

  /// e.g., "14:30"
  String get time24Hour => DateFormat('HH:mm').format(this);

  /// e.g., "14:30:45"
  String get time24HourWithSeconds => DateFormat('HH:mm:ss').format(this);
}
