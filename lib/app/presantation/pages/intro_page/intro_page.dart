import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/bg_widget.dart';
import 'package:dwallet/app/presantation/pages/intro_page/widget/page_view_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';

import '../../utils/globals.dart';

class IntroPage extends StatelessWidget{
  IntroPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
      child: Scaffold(
          backgroundColor: Get.isDarkMode
              ? Themes.dark.backgroundColor
              : Themes.light.backgroundColor,
          body:
          BgWidget(
            child: Padding(
              padding: EdgeInsets.all(mainPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  const SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: PageViewWidget(),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style:Get.isDarkMode? Themes.dark.elevatedButtonTheme.style:Themes.light.elevatedButtonTheme.style,
                              onPressed: () => Get.toNamed(AppRoutes.agreementPage),
                              child: const Text("Create a new wallet"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0,),
                      InkWell(
                          borderRadius: BorderRadius.circular(BUTTON_RADIUS),
                          onTap: () => Get.toNamed(AppRoutes.importWalletPage),
                          child:
                          Row(
                            children: [
                              Expanded(
                                child:
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text(
                                      "I already have a wallet",
                                      style: TextStyle(fontSize: 18,color: Get.theme.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 16.0,),
                    ],
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
