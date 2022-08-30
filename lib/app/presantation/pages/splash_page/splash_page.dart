import 'package:dwallet/app/presantation/controllers/splash_page_controller.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashPageController> {
  SplashPage({Key? key}) : super(key: key){
    controller.getPrivateKey();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child:
            BgWidget(child: SpinKitFadingCube(color: Get.theme.primaryColor)),
          )),
    );
  }
}
