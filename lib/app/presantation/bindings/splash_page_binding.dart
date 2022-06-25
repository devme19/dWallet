
import 'package:dwallet/app/domain/repository/app_repository.dart';
import 'package:dwallet/app/domain/use_cases/private_key/get_private_key_usecase.dart';
import 'package:dwallet/app/presantation/controllers/splash_page_controller.dart';
import 'package:get/instance_manager.dart';

class SplashPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GetPrivateKeyUseCase>(
            () => GetPrivateKeyUseCase(repository: Get.find<AppRepository>()));
    Get.lazyPut<SplashPageController>(() => SplashPageController());
  }

}