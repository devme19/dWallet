import 'package:dwallet/app/core/either.dart';
import 'package:dwallet/app/core/failures.dart';
import 'package:dwallet/app/domain/use_cases/setting/security/set_passcode_usecase.dart';
import 'package:dwallet/app/presantation/pages/security_page/security_page.dart';
import 'package:flutter/material.dart';
import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/use_cases/setting/language/get_language_use_case.dart';
import 'package:dwallet/app/domain/use_cases/setting/language/set_language_use_case.dart';
import 'package:dwallet/app/domain/use_cases/setting/theme/set_theme_mode_use_case.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../domain/use_cases/setting/security/get_passcode_usecase.dart';
import '../../domain/use_cases/setting/theme/get_theme_mode_use_case.dart';
import '../../domain/use_cases/setting/theme/set_theme_mode_use_case.dart';

class SettingController extends GetxController{
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  RxBool isDark = false.obs;
  RxBool isEn = true.obs;
  RxBool enableSecurity = false.obs;
  String passCode="";
  GetThemeModeUseCase getThemeModeUseCase = Get.find();
  SetThemeModeUseCase setThemeModeUseCase = Get.find();

  SetLanguageUseCase setLanguageUseCase = Get.find();
  GetLanguageUseCase getLanguageUseCase = Get.find();

  @override
  void onInit() {
    super.onInit();

    getThemeModeUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        isDark.value = response.right;
        Get.changeThemeMode(isDark.value?ThemeMode.dark:ThemeMode.light);
      }else if(response.isLeft){
        // CacheException
        print("CacheException");
      }
    });
    getLanguageUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        isEn.value = response.right;
      }else if(response.isLeft){
        // CacheException
        print("CacheException");
      }
    });

  }
  toggleLanguage(){
    isEn.value = !isEn.value;
    Get.updateLocale(isEn.value?const Locale('en', 'US'):const Locale('fa', 'IR'));
    setLanguageUseCase.call(Params(boolValue: isEn.value));
  }
  Future<String> getPassCode()async{
    GetPassCodeUseCase getPassCodeUseCase = Get.find();
    Either<Failure,String> response = await getPassCodeUseCase.call(NoParams());
    if(response.isRight){
      passCode = response.right;
      return response.right;
    }
    else {
      return "";
    }
  }
  onSecurityTap() async{
    Get.bottomSheet(
        isScrollControlled: true,
        Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 80),
            child: SecurityPage(addPassCode: !enableSecurity.value,)));
    // if(enableSecurity.value){
    //
    // }
    // GetPassCodeUseCase getPassCodeUseCase = Get.find();
    // String passCode = await getPassCode();
    // getPassCodeUseCase.call(NoParams()).then((response) {
    //   if(response.isRight){
    //     if(response.right == null || response.right == ""){
    //       Get.bottomSheet(
    //           isScrollControlled: true,
    //           Container(
    //               color: Colors.transparent,
    //               margin: EdgeInsets.only(top: 80),
    //               child: SecurityPage()));
    //     }
    //     else{
    //       enableSecurity.value = !enableSecurity.value;
    //     }
    //   }else if(response.isLeft){
    //
    //   }
    // });
    //
    // if(enableSecurity.value){}
  }
  setPassCode(String passCode){
    SetPassCodeUseCase setPassCodeUseCase = Get.find();
    setPassCodeUseCase.call(Params(value: passCode)).then((response) {
      if(response.isRight){
        if(passCode.isNotEmpty){
          Fluttertoast.showToast(msg:"PassCode successfully added");
        }

        Get.back();
      }else if(response.isLeft){

      }
    });
  }
  toggleTheme() {
    isDark.value = !isDark.value;
    if(isDark.value){
      themeMode.value = ThemeMode.dark;
    }else{
      themeMode.value = ThemeMode.light;
    }
    Get.changeThemeMode(isDark.value?ThemeMode.dark:ThemeMode.light);
    setThemeModeUseCase.call(Params(boolValue: isDark.value));
  }
}
