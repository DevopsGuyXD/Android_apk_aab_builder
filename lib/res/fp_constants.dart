import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FPConstants {
  static int bg_color_env = int.parse(dotenv.env['FPLOGOBACKGROUNDCOLOR']!);
  static int fg_color_env = int.parse(dotenv.env['FPLOGOFOREGROUNDCOLOR']!);
  static String fpTag = dotenv.env['FPTAG']!;
  static String fpRootAliasUri = dotenv.env['FPROOTALIASURI']!;
  static String fpLogoUri = dotenv.env['FPLOGOURI']!;
  static Color fpLogoBackgroundColor = Color(bg_color_env);
  static Color fpLogoForegroundColor = Color(fg_color_env);

  static RegExp fpStaticContentRegex =
      RegExp(r'.*\.(css|js|jpg|png|jpeg|webp|svg|pdf|html|htm)$');
  static const String httpScheme = 'HTTP://';
  static const String httpsScheme = 'HTTPS://';
}
