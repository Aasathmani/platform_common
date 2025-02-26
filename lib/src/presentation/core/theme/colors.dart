import 'package:flutter/material.dart' show Color;

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    String hex = hexColor.toUpperCase().replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    return int.parse(hex, radix: 16);
  }

  HexColor(String hexColor) : super(_getColorFromHex(hexColor));
}

class AppColors {
  AppColors._();

  static const Color mildBlue = Color(0xFF5D76A8);
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightBlack = Color(0xFF454545);
  static const Color extraLightBlack = Color(0xFF1A1A1A);
  static const Color extraLightBlueShade = Color(0xFFEFF7FF);
  static const Color red = Color(0xFFF5564E);
  static const Color darkRed = Color(0xFFEB5757);
  static const Color denim = Color(0xFF1377B9);
  static const Color denimBlue = Color(0xFF124BAE);
  static const Color lightRed = Color(0xFFE46574);
  static const Color lightBlue = Color(0xFF64B8F1);
  static const Color lightYellow = Color(0xFFF1B964);
  static const Color darkWhite = Color(0xFFF9F9F9);
  static const Color extraLightBlue = Color(0xFFC4D3F3);
  static const Color blue = Color(0xFFC4D3F3);
  static const Color lightGrey2 = Color(0xFFE9E9E9);
  static const Color extraLightGrey = Color(0xFFF5F5F5);
  static const Color blueIconColor = Color(0xFF4E87DE);

  static const Color darkPink = Color(0xFFE02D57);
  static const Color softPeach = Color(0xFFF2E9E8);
  static const Color parisWhite = Color(0xFFD6E6E2);
  static const Color mandy = Color(0xFFE3486A);
  static const Color tundora = Color(0xFF464646);
  static const Color tundoraLight = Color(0xFF4A4A4A);
  static const Color tundoraDark = Color(0xFF4F4F4F);
  static const Color lightGrey = Color(0xFFE3E3E3);
  static const Color lightGrey1 = Color(0xFFF4F6F6);
  // static const Color lightGrey = Color(0xFFDEDEDE);
  static const Color dustyGrey = Color(0xFF989898);
  static const Color grey = Color(0xFF8C8C8C);
  static const Color grey2 = Color(0xFF4F4F4F);
  static const Color bayLeaf = Color(0xFF71A780);
  static const Color alto = Color(0xFFD8D8D8);
  static const Color roseBud = Color(0xFFFBBAA3);
  static const Color roseWhite = Color(0xFFF9EAE7);
  static const Color dullPink = Color(0xFFDAABB5);
  static const Color dullRose = Color(0xFFC7A3BD);
  static const Color pink = Color(0xFFAC98CD);
  static const Color paleRed = Color(0xFFFFC5C4);
  static const Color chetWodeBlue = Color(0xFF8989E0);
  static const Color alphaBlack = Color(0x20000000);
  static const Color waxFlower = Color(0xFFFFBCA0);
  static const Color wedgewood = Color(0xFF458495);
  static const Color deYork = Color(0xFF7DB88D);
  static const Color blueRibbon = Color(0xFF0F72F8);
  static const Color duskBlue = Color(0xFF6873E2);
  static const Color duskBlue1 = Color(0xFF5361EE);
  static const Color aquamarine = Color(0xFF80FDF7);
  static const Color dustyGray = Color(0xFF9C9C9C);
  static const Color darkGray = Color(0xFFC4C4C4);
  static const Color dustyGray20 = Color(0x349C9C9C);
  static const Color silver = Color(0xFFB9B9B9);
  static const Color alphaWhite = Color(0xB3ffffff);
  static const Color alphaWhiteAA = Color(0xAAffffff);
  static const Color alphaWhite88 = Color(0x88ffffff);
  static const Color cornflowerBlue = Color(0xFF0B3F86);
  static const Color darkBlue = Color(0xFF333869);
  static const Color ming = Color(0xFF3F8884);
  static const Color caution = Color(0xFF629B8A);
  static const Color outerSpace = Color(0xFF222E2B);
  static const Color outerSpaceDark = Color(0xFF1C2825);
  static const Color corduroy = Color(0xFF5E726D);
  static const Color capeCod = Color(0xFF394743);
  static const Color codGray = Color(0xCB1A1919);
  static const Color mercury = Color(0xCBE7E7E7);
  static const Color mercuryAlpha = Color(0x67E7E7E7);
  static const Color mercuryLight = Color(0x4DE7E7E7);
  static const Color ivory = Color(0xFFFFFFF0);
  static const Color gallery = Color(0xFFEBEBEB);
  static const Color alabaster = Color(0xFFFAFAFA);
  static const Color whileLilac = Color(0xFFECEDF8);
  static const Color whileLilacAlpha = Color(0x66ECEDF8);
  static const Color froly = Color(0xFFF1706E);
  static const Color mountainMeadow = Color(0xFF21C979);
  static const Color green = Color(0xFF27AE60);
  static const Color greenDarker = Color(0xFF219554);
  static const Color limeGreen = Color(0xFF32CD32);
  static const Color merino = Color(0xFFFAF7F1);
  static const Color smaltBlue = Color(0xFF4E8C93);
  static const Color helpOverlay = Color(0xFF0078A4);
  static const Color palette = Color(0xFF6873E2);
  static const Color lightPalette = Color(0xff7575E0);
  static const Color dusk = Color(0xffEF90B3);

  static const Color primary = Color(0xff2B3164);
  static const Color primaryDark = Color(0xff2B3164);
  static const Color primaryLight = Color(0xff2B3164);
  static const Color accent = Color(0xff2B3164);

  static const Color bgSplash = Color(0xff2B3164);
  static const Color bgApp = Color(0xffF9F9F9);
  static const Color bgProfile = Color(0xffF3E9E8);

  static const Color yellow = Color(0xFFF8B114);
  static const Color blossom = Color(0xFFF0F3FB);
  static const Color blossomMauve = Color(0xFFE1E2EF);

  static const Color fadedBlue = Color(0xff5D76A8);
  static const Color extraFadedBlue = Color(0xff859DCE);
  static const Color peach = Color(0xFFF68681);
  static const Color darkPeach = Color(0xFFEF5A54);
  static const Color mildYellow = Color(0xFFEFBD17);
  static const Color mildGreen = Color(0XFF6DC124);
  static const Color candyRed = Color(0XFFFF0000);
  static const Color darkOffWhite = Color(0xFFE1E8F9);
  static const Color fadeWhite = Color(0xFFE2E2E2);
  static const Color lightBabyBlue = Color(0xff939FB7);
  static const Color offWhite = Color(0xFFF1F1F1);
  static const Color darkCornFlowerBlue = Color(0xFF5D76A8);
  static const Color cornFlowerBlue = Color(0xff859DCE);
  static const Color indigoBlue = Color(0xFF3B649C);
  static const Color lightIndigoBlue = Color(0xFFE1E8F8);
  static const Color ashColor = Color(0xFFE6E6E6);
}
