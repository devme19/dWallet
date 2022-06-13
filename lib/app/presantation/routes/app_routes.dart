import 'package:dwallet/app/presantation/bindings/login_page_binding.dart';
import 'package:dwallet/app/presantation/bindings/main_binding.dart';
import 'package:dwallet/app/presantation/pages/intro_page/intro_page.dart';
import 'package:dwallet/app/presantation/pages/login/login_page.dart';
import 'package:get/get.dart';

import '../bindings/setting_page_binding.dart';
import '../pages/home/home_page.dart';
import '../pages/setting/setting_page.dart';

class AppRoutes {
  static const String introPage = "/introPage";
  static const String homePage = "/homePage";
  static const String settingPage = "/settingPage";
}

class App {
  static final pages = [
    GetPage(
      name: AppRoutes.introPage,
      page: () => IntroPage(),
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
        name: AppRoutes.settingPage,
        page: () => const SettingPage(),
        bindings: [MainBinding(), SettingPageBinding()]),
  ];
}
