part of 'extensions.dart';

extension ThemeExtension on BuildContext {
  /// Provides access to colors in the theme.
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Provides access to text styles in the theme.
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the height of the device.
  double get height => MediaQuery.sizeOf(this).height;

  /// Returns the width of the device.
  double get width => MediaQuery.sizeOf(this).width;

  /// Returns the width of the device multiplied by the given value.
  double dynamicWidth(double val) => width * val;

  /// Returns the height of the device multiplied by the given value.
  double dynamicHeight(double val) => height * val;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(height * 0.01);
  EdgeInsets get paddingMedium => EdgeInsets.all(height * 0.02);
  EdgeInsets get paddingHigh => EdgeInsets.all(height * 0.03);

  EdgeInsets get horizontalPaddingLow =>
      EdgeInsets.symmetric(horizontal: width * 0.02);
  EdgeInsets get horizontalPaddingMedium =>
      EdgeInsets.symmetric(horizontal: width * 0.04);
  EdgeInsets get horizontalPaddingHigh =>
      EdgeInsets.symmetric(horizontal: width * 0.06);

  EdgeInsets get verticalPaddingLow =>
      EdgeInsets.symmetric(vertical: height * 0.01);
  EdgeInsets get verticalPaddingMedium =>
      EdgeInsets.symmetric(vertical: height * 0.02);
  EdgeInsets get verticalPaddingHigh =>
      EdgeInsets.symmetric(vertical: height * 0.03);
}

extension BorderRadiusExtension on BuildContext {
  BorderRadius get borderRadiusLow => BorderRadius.circular(width * 0.02);
  BorderRadius get borderRadiusMedium => BorderRadius.circular(width * 0.04);
  BorderRadius get borderRadiusHigh => BorderRadius.circular(width * 0.06);
}

extension BoxShadowExtension on BuildContext {
  List<BoxShadow> get boxShadowLight => [
        BoxShadow(
          color: Colors.black.withAlpha(25),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  List<BoxShadow> get boxShadowMedium => [
        BoxShadow(
          color: Colors.black.withAlpha(25),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  List<BoxShadow> get boxShadowHigh => [
        BoxShadow(
          color: Colors.black.withAlpha(25),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ];
}
