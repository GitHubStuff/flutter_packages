// // import 'package:dartz/dartz.dart';
// import 'package:enum_to_string/enum_to_string.dart';
// import 'package:flutter/cupertino.dart';

// // import 'package:flutter/material.dart';
// // import 'package:xfer/xfer.dart';

// import '../../theme_management_package.dart';
// import '../exceptions.dart';
// import 'brightness_extension.dart';

// // import 'brightness_extension.dart';

// extension ThemeTypeExtension on ThemeType {
// //   static String _key = 'com.icodeforyou.theme_type_extension.key';

//   static ThemeType ofPlatform(BuildContext context) => MediaQuery.of(context).platformBrightness.asThemeType();

//   bool isLightTheme() => (this == ThemeType.applicationLight || this == ThemeType.platformLight)
//       ? true
//       : (this != ThemeType.unknown)
//           ? false
//           : throw IncompleteThemeCubit();

//   String asString() => EnumToString.convertToString(this);
//   bool isPlatform() => (this == ThemeType.platformDark || this == ThemeType.platformLight)
//       ? true
//       : (this != ThemeType.unknown)
//           ? false
//           : throw IncompleteThemeCubit();

// //   static ThemeType fromBrightness({required BuildContext context}) => (MediaQuery.of(context).platformBrightness).asThemeType();

// //   static Future<Either<XferFailure, XferResponse>> setTheme({required ThemeType type}) async => await Xfer().post(
// //         'pref://$_key',
// //         body: type.asString(),
// //       );

// //   static Future<ThemeType> getThemeType(BuildContext context) async {
// //     final xfer = Xfer();
// //     final platformTheme = fromBrightness(context: context);
// //     final Either<XferFailure, XferResponse> result = await xfer.get(
// //       'pref://$_key',
// //       value: platformTheme.asString(),
// //     );
// //     return result.fold(
// //       (exception) {
// //         throw CannotReadTheme('Cannot read key: $_key');
// //       },
// //       (right) async {
// //         ThemeType parsed = EnumToString.fromString(ThemeType.values, right.body)!;
// //         switch (parsed) {
// //           case ThemeType.applicationDark:
// //           case ThemeType.applicationLight:
// //             break;
// //           case ThemeType.platformDark:
// //           case ThemeType.platformLight:
// //             parsed = platformTheme;
// //             await xfer.post('pref://$_key', body: parsed.asString());
// //             break;
// //           case ThemeType.unknown:
// //             parsed = ThemeType.platformLight;
// //             break;
// //         }
// //         return parsed;
// //       },
// //     );
// //   }
// }
