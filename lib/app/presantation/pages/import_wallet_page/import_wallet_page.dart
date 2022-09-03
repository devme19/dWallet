import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/app_bar_widget.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/bg_widget.dart';
import 'package:dwallet/app/presantation/pages/import_wallet_page/widgets/secret_phrase_lenght.dart';
import 'package:dwallet/app/presantation/pages/import_wallet_page/widgets/text_field_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:dwallet/app/presantation/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ImportWalletPage extends StatefulWidget {
  const ImportWalletPage({Key? key}) : super(key: key);

  @override
  _ImportWalletPageState createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {
  WalletController controller = Get.find();
  int index = 12;
  List<TextEditingController> textEditingControllers = [];
  changeIndex(int value) {
    index = value;
    createMnemonicTextField(index);
  }
  pasteSecretPhrases()async{
    ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
    List<String> secretPhrasesList=[];
    secretPhrasesList.addAll(cdata!.text!.split(' '));
    for(int i =0; i< secretPhrasesList.length;i++){
      textEditingControllers[i].text = secretPhrasesList[i];
    }
  }
  List<Widget> secretPhraseField = [];

  List<Widget> createMnemonicTextField(int length){
    List<Widget> widgets=[];
    List<Widget> rows=[];
    textEditingControllers.clear();
    for(int i=0; i<length;i++){
      textEditingControllers.add(TextEditingController());
      if(i==0)
      {
        widgets.add(
            TextFieldWidget(index: 1,controller: textEditingControllers[i],));
      }
      else
      if((i)%3 != 0) {
        widgets.add(
            TextFieldWidget(index: i+1,controller: textEditingControllers[i]));
      }
      else{
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...widgets],));
        widgets = [];
        widgets.add(
            TextFieldWidget(index: i+1,controller: textEditingControllers[i]));
      }
    }
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...widgets],));
    setState(() {});
    return rows;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createMnemonicTextField(index);
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
          // floatingActionButton: FloatingActionButton(onPressed: () {
          //   controller.getBalance();
          // },),
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
              child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Enter your Secret Phrase",
                        style: Themes.dark.textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Write down or paste your wallet Secret Phrase (12) words in the right order.",
                        style: Themes.dark.textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    Container(
                      width: 200,
                      // margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  changeIndex(12);
                                });
                              },
                              child: SecretPhraseLength(
                                lengthCOlor: index == 12 ?Get.isDarkMode? Colors.black : Colors.white:Get.isDarkMode?Colors.white : Colors.black,
                                length: 12,
                                fillColor:
                                index == 12 ? Get.isDarkMode?Colors.white:Colors.black:Colors.transparent,
                              )),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  changeIndex(16);
                                });
                              },
                              child: SecretPhraseLength(
                                lengthCOlor: index == 16 ? Get.isDarkMode? Colors.black : Colors.white:Get.isDarkMode?Colors.white : Colors.black,
                                length: 16,
                                fillColor:
                                index == 16 ? Get.isDarkMode?Colors.white:Colors.black:Colors.transparent,
                              )),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  changeIndex(24);
                                });
                              },
                              child: SecretPhraseLength(
                                length: 24,
                                lengthCOlor: index == 24 ? Get.isDarkMode? Colors.black : Colors.white:Get.isDarkMode?Colors.white : Colors.black,
                                fillColor:
                                index == 24 ? Get.isDarkMode?Colors.white:Colors.black:Colors.transparent,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    ...createMnemonicTextField(index),
                  ],
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(     // <-- TextButton
                onPressed: () {
                  print("paste");
                  pasteSecretPhrases();
                },
                icon: Image.asset('assets/images/icons/paste.png',color: Get.theme.primaryColor),
                label: Text('Paste',style: TextStyle(color: Get.theme.primaryColor),),
              ),
            ),
            const SizedBox(height: 16.0,),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style:Get.isDarkMode? Themes.dark.elevatedButtonTheme.style:Themes.light.elevatedButtonTheme.style,
                        onPressed: () {
                          String secretPhrase="";
                          for(TextEditingController item in textEditingControllers){
                            secretPhrase+= '${item.text} ';
                          }
                          secretPhrase = secretPhrase.substring(0,secretPhrase.length-1);
                          print(secretPhrase);
                          controller.importWallet(secretPhrase);
                        }, child: const Text("Import"))),
              ],
            ),
            const SizedBox(height: 8.0,),
          ],
        ),
      );
  }
}