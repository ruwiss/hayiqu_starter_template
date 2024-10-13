part of 'extensions.dart';

extension DateTimeExtensions on DateTime {
  /// Verilen zaman ile şimdiki zaman farkını bulup
  /// - şimdi
  /// - 30 dk önce
  /// - 2 gün önce
  /// - 1 ay önce
  /// çıktıları verir
  String passingTime(DateTime? datetime) {
    if (datetime == null) {
      return " - ";
    }

    final differenceTime = DateTime.now().difference(datetime);
    String result = "";
    if (differenceTime.inMinutes < 1) {
      return "şimdi";
    } else if (differenceTime.inMinutes < 60) {
      result = "${differenceTime.inMinutes} dk";
    } else if (differenceTime.inHours < 48) {
      result = "${differenceTime.inHours} saat";
    } else if (differenceTime.inDays < 30) {
      result = "${differenceTime.inDays} gün";
    } else {
      result = "${(differenceTime.inDays ~/ 30)} ay";
    }
    return "$result önce";
  }

  /// Verilen zaman ile şimdiki zaman farkını bulup
  /// - şimdi
  /// - 30dk
  /// - 2s
  /// - 1g
  /// - 3ay
  /// çıktıları verir
  String passingTimeSort(DateTime? datetime) {
    if (datetime == null) {
      return " - ";
    }

    final differenceTime = DateTime.now().difference(datetime);
    String result = "";
    if (differenceTime.inMinutes < 1) {
      result = "şimdi";
    } else if (differenceTime.inMinutes < 60) {
      result = "${differenceTime.inMinutes}dk";
    } else if (differenceTime.inHours < 48) {
      result = "${differenceTime.inHours}s";
    } else if (differenceTime.inDays < 30) {
      result = "${differenceTime.inDays}g";
    } else {
      result = "${(differenceTime.inDays ~/ 30)}ay";
    }
    return result;
  }
}
