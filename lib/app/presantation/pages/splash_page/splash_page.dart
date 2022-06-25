import 'package:dwallet/app/presantation/controllers/splash_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashPageController> {
  SplashPage({Key? key}) : super(key: key){
    controller.getPrivateKey();
  }


  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          body: Center(
            child:CircularProgressIndicator()
          )),
    );
  }
}
