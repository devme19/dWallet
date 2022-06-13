import 'package:dwallet/app/domain/use_cases/user/login_use_case.dart';
import 'package:dwallet/app/domain/use_cases/user/verification_use_case.dart';
import 'package:dwallet/app/presantation/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../domain/repository/app_repository.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginUseCase>(
        () => LoginUseCase(repository: Get.find<AppRepository>()));
    Get.lazyPut<VerificationUseCase>(
        () => VerificationUseCase(repository: Get.find<AppRepository>()));
    Get.lazyPut(() => AuthController());
  }
}
