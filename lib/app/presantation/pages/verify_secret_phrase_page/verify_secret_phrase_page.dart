import 'package:dwallet/app/presantation/pages/global_widgets/app_bar_widget.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/bg_widget.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/success_dialog.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:dwallet/app/presantation/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet_controller.dart';

class VerifySecretPhrasePage extends GetView<WalletController> {
  VerifySecretPhrasePage({Key? key}) : super(key: key){
    controller.phraseItems.clear();
    controller.createPhraseItems(controller.shuffledSecretPhraseList,add: controller.add,remove: controller.remove);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.isDarkMode
            ? Themes.dark.backgroundColor
            : Themes.light.backgroundColor,
        body:BgWidget(child: body()),
      ),
    );
  }
  Widget body(){
    return
      Obx(()=>Padding(
        padding: EdgeInsets.only(left: mainPadding, right: mainPadding, bottom: mainPadding),
        child: Column(
          children: [
            const AppBarWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Verify Secret Phrase",
                          style: Themes.dark.textTheme.headline1,
                        ),
                        const SizedBox(height: 16.0,),
                        Text(
                          'Tap the words to put them next to each other in the correct order.',
                          style: Themes.dark.textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0,),
                        Container(
                          height: 270,
                          padding: const EdgeInsets.all(16.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: IColor().DARK_TEXT_COLOR.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          child: Column(
                              children:[
                                ...controller.createSelectedPhraseItems(controller.selectedPhrasesList)
                              ]
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0,),
                    Column(
                        children:[
                          ...controller.phraseItems
                        ]
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0,),
            Column(
              children: [
                controller.isWrong.value?
                Container(
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffFF453A).withOpacity(0.1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "The Secret Phrase (12 words) that you entered is in wrong order!",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.normal,
                            color: Color(0xffFF453A)),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ):const SizedBox(height: 80,),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style:Get.isDarkMode? Themes.dark.elevatedButtonTheme.style:Themes.light.elevatedButtonTheme.style,
                            onPressed: () async{
                              if(controller.verifySecretPhrase()){
                                controller.savePrivateKey();
                                await controller.getDefaultCoinsInfo();
                                controller.saveCoins();
                                Get.offAllNamed(AppRoutes.homePage);
                                Get.dialog(SuccessDialog(dialogAlert: 'Your wallet was successfully created.',onDone: (value)=>Get.back(),));
                              }
                            }, child: const Text("Continue"))),
                  ],
                ),
                const SizedBox(height: 8.0,),
              ],
            ),
          ],
        ),
      ));
  }

}