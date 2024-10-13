part of 'extensions.dart';

extension ThemeExtension on BuildContext {
  /// Tema üzerindeki renklere erişim sağlar
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Tema üzerindeki metin stillerine erişim sağlar
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Cihazın yüksekliğini döndürür
  double get height => MediaQuery.sizeOf(this).height;

  /// Cihazın genişliğini döndürür
  double get width => MediaQuery.sizeOf(this).width;

  /// Cihaz yüksekliğinin %1'ini döndürür
  double get lowValue => height * 0.01;

  /// Cihaz yüksekliğinin %2'sini döndürür
  double get defaultValue => height * 0.02;

  /// Cihaz yüksekliğinin %5'ini döndürür
  double get highValue => height * 0.05;

  /// Cihaz yüksekliğinin %10'unu döndürür
  double get veryhighValue1x => height * 0.1;

  /// Cihaz yüksekliğinin %20'sini döndürür
  double get veryhighValue2x => height * 0.2;

  /// Cihaz yüksekliğinin %30'uni döndürür
  double get veryhighValue3x => height * 0.3;

  /// Cihaz yüksekliğinin %40'ını döndürür
  double get veryhighValue4x => height * 0.4;

  /// Cihaz yüksekliğinin %50'sini döndürür
  double get veryhighValue5x => height * 0.5;

  /// Cihaz genişliği * değer
  double dynamicWidth(double val) => width * val;

  /// Cihaz yüksekliği * değer
  double dynamicHeight(double val) => height * val;
}

extension PaddingExtension on BuildContext {
  /// Her yerden %1 padding ekler
  EdgeInsets get paddingAllLow => EdgeInsets.all(lowValue);

  /// Her yerden %2 padding ekler
  EdgeInsets get paddingAllDefault => EdgeInsets.all(defaultValue);

  /// Her yerden %5 padding ekler
  EdgeInsets get paddingAllHigh => EdgeInsets.all(highValue);

  /// Yatay olarak %1 padding ekler
  EdgeInsets get paddingHorizontalLow =>
      EdgeInsets.symmetric(horizontal: lowValue);

  /// Yatay olarak %2 padding ekler
  EdgeInsets get paddingHorizontalDefault =>
      EdgeInsets.symmetric(horizontal: defaultValue);

  /// Yatay olarak %5 padding ekler
  EdgeInsets get paddingHorizontalHigh =>
      EdgeInsets.symmetric(horizontal: highValue);

  /// Dikey olarak %1 padding ekler
  EdgeInsets get paddingVerticalLow => EdgeInsets.symmetric(vertical: lowValue);

  /// Dikey olarak %2 padding ekler
  EdgeInsets get paddingVerticalDefault =>
      EdgeInsets.symmetric(vertical: defaultValue);

  /// Dikey olarak %5 padding ekler
  EdgeInsets get paddingVerticalHigh =>
      EdgeInsets.symmetric(vertical: highValue);

  /// Sağdan %1 padding ekler
  EdgeInsets get paddingRightLow => EdgeInsets.only(right: lowValue);

  /// Sağdan %2 padding ekler
  EdgeInsets get paddingRightDefault => EdgeInsets.only(right: defaultValue);

  /// Sağdan %5 padding ekler
  EdgeInsets get paddingRightHigh => EdgeInsets.only(right: highValue);

  /// Soldan %1 padding ekler
  EdgeInsets get paddingLeftLow => EdgeInsets.only(left: lowValue);

  /// Soldan %2 padding ekler
  EdgeInsets get paddingLeftDefault => EdgeInsets.only(left: defaultValue);

  /// Soldan %5 padding ekler
  EdgeInsets get paddingLeftHigh => EdgeInsets.only(left: highValue);

  /// Yukarıdan %1 padding ekler
  EdgeInsets get paddingTopLow => EdgeInsets.only(top: lowValue);

  /// Yukarıdan %2 padding ekler
  EdgeInsets get paddingTopDefault => EdgeInsets.only(top: defaultValue);

  /// Yukarıdan %5 padding ekler
  EdgeInsets get paddingTopHigh => EdgeInsets.only(top: highValue);

  /// Aşağıdan %1 padding ekler
  EdgeInsets get paddingBottomLow => EdgeInsets.only(bottom: lowValue);

  /// Aşağıdan %2 padding ekler
  EdgeInsets get paddingBottomDefault => EdgeInsets.only(bottom: defaultValue);

  /// Aşağıdan %5 padding ekler
  EdgeInsets get paddingBottomHigh => EdgeInsets.only(bottom: highValue);
}
