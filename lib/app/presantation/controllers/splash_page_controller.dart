import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/use_cases/private_key/get_private_key_usecase.dart';
import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/security_widget.dart';
import 'package:dwallet/app/presantation/pages/security_page/security_page.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController{

  SettingController controller = Get.find();
  getPrivateKey(){
    GetPrivateKeyUseCase getPrivateKeyUseCase = Get.find();
    getPrivateKeyUseCase.call(NoParams()).then((response) async{
      await Future.delayed(const Duration(seconds: 1));
      if(response.isRight){
        if(response.right.isNotEmpty){
          controller.getPassCode().then((passCode) {
            if(passCode.isEmpty){
              Get.offAllNamed(AppRoutes.homePage,parameters: {'initial':'false'});
            }else{
              Get.to(Scaffold(body: SecurityWidget(isSplash: true,addPassCode: false),));
            }
          });

          // Get.offAndToNamed(AppRoutes.introPage);
        }
        else{
          Get.offAndToNamed(AppRoutes.introPage);
        }
      }else if(response.isLeft){

      }
    });
  }

}