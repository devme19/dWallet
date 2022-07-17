import 'package:dwallet/app/presantation/bindings/main_binding.dart';
import 'package:dwallet/app/presantation/bindings/splash_page_binding.dart';
import 'package:dwallet/app/presantation/pages/agreement_page/agreement_page.dart';
import 'package:dwallet/app/presantation/pages/coin_page/coin_page.dart';
import 'package:dwallet/app/presantation/pages/home_page/home_page.dart';
import 'package:dwallet/app/presantation/pages/import_wallet_page/import_wallet_page.dart';
import 'package:dwallet/app/presantation/pages/intro_page/intro_page.dart';

import 'package:dwallet/app/presantation/pages/secret_phrase_page/secret_phrase_page.dart';
import 'package:dwallet/app/presantation/pages/setting_page/setting_page.dart';
import 'package:dwallet/app/presantation/pages/splash_page/splash_page.dart';
import 'package:dwallet/app/presantation/pages/verify_secret_phrase_page/verify_secret_phrase_page.dart';
import 'package:get/get.dart';

import '../bindings/setting_page_binding.dart';

class AppRoutes {
  static const String introPage = "/introPage";
  static const String homePage = "/homePage";
  static const String settingPage = "/settingPage";
  static const String splashPage = "/splashPage";
  static const String secretPhrasePage = "/secretPhrasePage";
  static const String agreementPage = "/agreementPage";
  static const String verifySecretPhrasePage = "/verifySecretPhrasePage";
  static const String importWalletPage = "/importWalletPage";
  static const String coinPage = "/coinPage";
}

class App {
  static final pages = [
    GetPage(
        name: AppRoutes.splashPage,
        page: () => SplashPage(),
        bindings:[MainBinding(),SplashPageBinding()]
    ),
    GetPage(
      name: AppRoutes.introPage,
      page: () => const IntroPage(),
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.importWalletPage,
      page: () => const ImportWalletPage(),
    ),
    GetPage(
      name: AppRoutes.coinPage,
      page: () =>  CoinPage(),
    ),
    GetPage(
        name: AppRoutes.settingPage,
        page: () => const SettingPage(),
        bindings: [MainBinding(), SettingPageBinding()]),
    GetPage(
        name: AppRoutes.secretPhrasePage, page: () => SecretPhrasePage()),
    GetPage(
        name: AppRoutes.agreementPage, page: () => const AgreementPage()),
    GetPage(
        name: AppRoutes.verifySecretPhrasePage, page: () => VerifySecretPhrasePage())
  ];
}