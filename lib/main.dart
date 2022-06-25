import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'app/core/use_case.dart';
import 'app/data/data_sources/remote/client.dart';
import 'app/domain/use_cases/setting/language/get_language_use_case.dart';
import 'app/domain/use_cases/setting/theme/get_theme_mode_use_case.dart';
import 'app/presantation/bindings/main_binding.dart';
import 'app/presantation/routes/app_routes.dart';
import 'app/presantation/theme/themes.dart';
import 'app/presantation/utils/messages.dart';

bool isEn = true;
Future<bool> getLanguage() async {
  GetLanguageUseCase getLanguageUseCase = Get.find();
  return (await getLanguageUseCase.call(NoParams())).right;
}

getThemeMode() async {
  bool isDarkMode = false;
  GetThemeModeUseCase getThemeModeUseCase = Get.find();
  isDarkMode = (await getThemeModeUseCase.call(NoParams())).right;
  Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
}

void main() async {
  Client().init();
  await GetStorage.init();
  MainBinding().dependencies();
  isEn = await getLanguage();
  await getThemeMode();
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      GetMaterialApp(
      builder: DevicePreview.appBuilder,
      getPages: App.pages,
      title: 'dWallet',
      theme: Themes.dark,
      locale: isEn ? const Locale('en', 'US') : const Locale('fa', 'IR'),
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splashPage,

      translations: Messages(),
      fallbackLocale: const Locale('en', 'US'),
      // initialBinding:SettingPageBinding()
      // initialBinding: MainBinding(),
    );
  }
}
