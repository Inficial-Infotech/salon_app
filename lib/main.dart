import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salon_app/app/routes/app_pages.dart';
import 'package:salon_app/app/ui/screenDesign/Auth/sign_in.dart';
import 'package:salon_app/app/ui/theme/app_theme.dart';
import 'package:salon_app/app/ui/utils/math_utils.dart';
import 'package:salon_app/app/translations/app_translations.dart';

void main() async {
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.dark,
    ),
  );
  var diagonal = sqrt((Get.width * Get.width) + (Get.height * Get.height));

  var isWebView = GetStorage();
  if (diagonal > 1366) {
    isWebView.write("isWebView", true);
  } else if (diagonal > 1100) {
    isWebView.write("isTableView", true);
  } else {
    isWebView.write("isMobileView", true);
  }
  runApp(
    GetMaterialApp(
      navigatorKey: key,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.INITIAL,
      // theme: appThemeData,
      // darkTheme: appThemeData,
      theme: appThemeData,
      darkTheme: appThemeDatadark,
      themeMode: ThemeMode.light,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      home: SignIn(),
      locale: Locale('en', 'US'),
      translationsKeys: AppTranslation.translations,
    ),
  );
}
