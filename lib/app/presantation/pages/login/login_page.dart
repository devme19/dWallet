import 'package:flutter/material.dart';
import 'package:dwallet/app/presantation/controllers/auth_controller.dart';
import 'package:dwallet/app/presantation/pages/login/widgets/enter_phone_number_widget.dart';
import 'package:dwallet/app/presantation/pages/login/widgets/phone_verfication_widget.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:dwallet/app/presantation/utils/state_status.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: Text("Clean Architecture".tr),
          actions: [
            // IconTheme(data: ThemeData().iconTheme, child: const Icon(Icons.settings))]
            IconButton(
              icon: Icon(Icons.settings,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () => Get.toNamed(AppRoutes.settingPage),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: body(),
        )));
  }

  Widget body() {
    if (controller.loginStateStatus.value != StateStatus.SUCCESS) {
      return EnterPhoneNumberWidget(
        onSubmit: onSubmit,
      );
    } else {
      return PhoneVerificationWidget(
        onVerificationSubmit: onVerificationSubmit,
      );
    }
  }

  onSubmit(String phoneNumber) => controller.login(phoneNumber);
  onVerificationSubmit(String code) => controller.verification(code);
}
