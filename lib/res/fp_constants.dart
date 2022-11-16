import 'dart:ui';

class FPConstants {
  static const String fpTag = 'DECCANSERAI';
  static const String fpRootAliasUri = 'https://www.rfconnectorncable.com/';
  static const String fpLogoUri =
      'https://fplogoimages.withfloats.com/actual/596d93358b90a7096c408baa.jpg';
  static const Color fpLogoBackgroundColor = Color(0xFF0c2b48);
  static const Color fpLogoForegroundColor = Color(0xFFbd8b51);

  static RegExp fpStaticContentRegex =
      RegExp(r'.*\.(css|js|jpg|png|jpeg|webp|svg|pdf|html|htm)$');
  static const String httpScheme = 'HTTP://';
  static const String httpsScheme = 'HTTPS://';
}
