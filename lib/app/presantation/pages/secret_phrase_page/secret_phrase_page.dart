import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/app_bar_widget.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/bg_widget.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:dwallet/app/presantation/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SecretPhrasePage extends GetView<WalletController> {
  SecretPhrasePage({Key? key}) : super(key: key){
    controller.createNewWallet();
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
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
      Padding(
        padding: EdgeInsets.only(left: mainPadding, right: mainPadding, bottom: mainPadding),
        child: Column(
          children: [
            const AppBarWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Your Secret Phrase",
                      style: Themes.dark.textTheme.headline1,
                    ),
                    const SizedBox(height: 16.0,),
                    Text(
                      controller.secretPhrase.value,
                      style: Themes.dark.textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0,),
                    Column(

                        children:[
                          ...controller.phraseItems
                        ]
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(     // <-- TextButton
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: controller.secretPhrase.value));
                          Get.snackbar(
                              'Secret phrases have been copied',
                              '',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black87
                          );
                          // Fluttertoast.showToast(
                          //     msg: "Secret phrases have been copied",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.CENTER,
                          //     // timeInSecForIosWeb: 1,
                          //     // backgroundColor: Colors.red,
                          //     // textColor: Colors.white,
                          //     // fontSize: 16.0
                          // );
                        },
                        icon: Image.asset('assets/images/icons/copy.png'),
                        label: Text('Copy',style: Themes.dark.textTheme.subtitle2,),
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffFF453A).withOpacity(0.1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Do not expose your Secret Phrase",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: "OpenSans",
                            fontSize: 18,
                            color: Color(0xffFF453A)),
                      ),
                      SizedBox(height: 8.0,),
                      Text(
                        "if someone has your Secret Phrase (12 words) they will have full access to your wallet.",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.normal,
                            color: Color(0xffFF453A)),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.verifySecretPhrasePage,arguments: controller.secretPhraseList);
                            }, child: const Text("Continue"))),
                  ],
                ),
                const SizedBox(height: 8.0,),
              ],
            ),
          ],
        ),
      );
  }
}
