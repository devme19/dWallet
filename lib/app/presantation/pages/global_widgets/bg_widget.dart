import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class BgWidget extends StatelessWidget {
  SettingController settingController = Get.find();
  Widget? child;
  BgWidget({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Stack(
      children: [
        settingController.isDark.value?
        SvgPicture.asset(
          "assets/images/Vector 2.svg",
          fit: BoxFit.cover,
        ):
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/lightBg.png",
            fit: BoxFit.fill,
            width: Get.width,
            height: Get.height,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child:
          child,
        )
      ],
    ));
  }
}
