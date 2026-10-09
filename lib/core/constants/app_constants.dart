class AppConstants {
  AppConstants._();

  static const String appName = 'Tally';

  // Rs (LKR) is the default currency for the MVP
  static const String currencyCode = 'LKR';
  static const String currencySymbol = 'Rs';

  // Money is stored as int minor units (cents): 100 = Rs 1.00
  static const int minorUnitsPerMajor = 100;
}