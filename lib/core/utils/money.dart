import '../constants/app_constants.dart';

class Money {
  Money._();

  /// 1250.50 -> 125050
  static int toMinor(double major) =>
      (major * AppConstants.minorUnitsPerMajor).round();

  /// 125050 -> 1250.50
  static double toMajor(int minor) =>
      minor / AppConstants.minorUnitsPerMajor;

  /// 125050 -> "Rs 1,250.50"
  static String format(int minor) {
    final negative = minor < 0;
    final abs = minor.abs();
    final whole = abs ~/ AppConstants.minorUnitsPerMajor;
    final cents = (abs % AppConstants.minorUnitsPerMajor)
        .toString()
        .padLeft(2, '0');

    final wholeStr = whole.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (_) => ',',
    );

    final sign = negative ? '-' : '';
    return '$sign${AppConstants.currencySymbol} $wholeStr.$cents';
  }
}