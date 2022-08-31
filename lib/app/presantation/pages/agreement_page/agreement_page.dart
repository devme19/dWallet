import 'package:dwallet/app/presantation/pages/agreement_page/widget/rule_box_widget.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/app_bar_widget.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/bg_widget.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:dwallet/app/presantation/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AgreementPage extends StatefulWidget {
  const AgreementPage({Key? key}) : super(key: key);

  @override
  State<AgreementPage> createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  bool? agree1 = false;
  bool? agree2 = false;
  bool? agree3 = false;
  bool? enableButton = false;
  checkRules() {
    if (agree1! && agree2! && agree3!) {
      enableButton = true;
    } else {
      enableButton = false;
    }

    setState(() {});
  }

  agreementRule1(bool value) {
    agree1 = value;
    checkRules();
  }

  agreementRule2(bool value) {
    agree2 = value;
    checkRules();
  }

  agreementRule3(bool value) {
    agree3 = value;
    checkRules();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.isDarkMode
            ? Themes.dark.backgroundColor
            : Themes.light.backgroundColor,
        body:
        BgWidget(child: body()),
      ),
    );

  }
  Widget body(){
    return Padding(
      padding: EdgeInsets.only(left: mainPadding, right: mainPadding, bottom: mainPadding),
      child: Column(
        children: [
          const AppBarWidget(),
          Expanded(
            child:
            SingleChildScrollView(
              child: Column(children: [
                Text(
                  "Backup your wallet now!",
                  style: Themes.dark.textTheme.headline1,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  "In the next step you will see  Secret Phrase (12 words) that allows you to recover a wallet",
                  style: Themes.dark.textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                    height: 200,
                    child: Image.asset("assets/images/intro2.png",height: 200)),
                const SizedBox(
                  height: 30.0,
                ),

                RulesBoxWidget(
                    rule:
                    "if i loose my secret phrase, my funds will be lost forever.",
                    agree: agree1,
                    result: agreementRule1),
                RulesBoxWidget(
                  rule:
                  "if i expose or show my secret phrase to anybody, my funds can get stolen.",
                  agree: agree2,
                  result: agreementRule2,
                ),
                RulesBoxWidget(
                  rule:
                  "it is my full responsibility to keep my secret phrase secure.",
                  agree: agree3,
                  result: agreementRule3,
                ),
              ],),
            ),
          ),
          const SizedBox(height: 16.0,),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style:Get.isDarkMode? Themes.dark.elevatedButtonTheme.style:Themes.light.elevatedButtonTheme.style,
                      onPressed: enableButton!
                          ? () {
                        Get.toNamed(AppRoutes.secretPhrasePage);
                      }
                          : null,
                      child: const Text("Continue")))
            ],
          ),
          const SizedBox(height: 8.0,),
        ],
      ),
    );
  }
}
