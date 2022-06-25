import 'package:dwallet/app/core/use_case.dart';
import 'package:dwallet/app/domain/use_cases/private_key/get_private_key_usecase.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController{

  getPrivateKey(){
    GetPrivateKeyUseCase getPrivateKeyUseCase = Get.find();
    getPrivateKeyUseCase.call(NoParams()).then((response) async{
      await Future.delayed(const Duration(seconds: 1));
      if(response.isRight){
        if(response.right.isNotEmpty){
          Get.offAndToNamed(AppRoutes.homePage);
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