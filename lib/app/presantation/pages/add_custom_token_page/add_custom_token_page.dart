import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/pages/add_custom_token_page/choose_network_page.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/input_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCustomTokenPage extends GetView<WalletController> {
  AddCustomTokenPage({Key? key}) : super(key: key);
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.033),
        height: Get.height * 0.9,
        decoration: BoxDecoration(
            color: settingController.isDark.value? IColor().DARK_HOME_LIST_BG_COLOR:IColor().LIGHT_HOME_LIST_BG_COLOR,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
        child: 
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: settingController.isDark.value?Colors.white54:Colors.black54),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 18, color: Get.theme.primaryColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Add Custom Token",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: Get.context!,
                            builder: (context) {
                              return ChooseNetworkPage(networks: controller.networks,selectedNetwork: controller.onNetworkChange,network: controller.selectedNetwork,);
                            });
                      },
                      child:
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: settingController.isDark.value? IColor().DARK_TOKEN_WIDGET_COLOR:IColor().LIGHT_TOKEN_WIDGET_COLOR,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Network",
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [

                                GetBuilder<WalletController>(builder: (controller){
                                  return Text(
                                    controller.selectedNetwork!.name!,
                                    style: TextStyle(
                                      // color:
                                      // IColor().DARK_TEXT_COLOR.withOpacity(0.5),
                                        fontSize: 18),
                                  );
                                }),
                                Icon(
                                  Icons.arrow_forward,
                                  // color: IColor().DARK_TEXT_COLOR.withOpacity(0.5),
                                  size: 20,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height:10.0),
                    Row(
                      children: [
                        Expanded(
                          child: InputWidget(hint: "Contract Address",controller: controller.contractAddressController,onSubmit: onContractAddressSubmitted),
                        ),
                        InkWell(
                          onTap: () async{
                            ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
                            if(cdata!.text!.isNotEmpty){
                              onContractAddressSubmitted(cdata.text!);
                            }
                            controller.contractAddressController.text = cdata.text!;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color:settingController.isDark.value?Color(0xff636366): Color(0xff636366)),
                                color:settingController.isDark.value?Color(0xff2C2C2E): Color(0xffE0E0E5)),
                            child: Image.asset("assets/images/icons/paste.png",color:Get.theme.primaryColor,height: 20,width: 20,),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Color(0xff636366)),
                                color:settingController.isDark.value?Color(0xff2C2C2E): Color(0xffE0E0E5)),
                            child: Image.asset("assets/images/icons/scan.png",color: Get.theme.primaryColor,height: 20,width: 20),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height:10.0),
                    Row(
                      children: [
                        Expanded(
                          child: InputWidget(hint: "Name",controller: controller.tokenNameController,),
                        ),
                      ],
                    ),
                    SizedBox(height:10.0),
                    Row(
                      children: [
                        Expanded(
                          child: InputWidget(hint: "Symbol",controller: controller.tokenSymbolController,),
                        ),
                      ],
                    ),
                    SizedBox(height:10.0),
                    Row(
                      children: [
                        Expanded(
                          child: InputWidget(hint: "Decimal",controller: controller.tokenDecimalController,),
                        ),
                      ],
                    ),
                    SizedBox(height:10.0),
                    const SizedBox(height: 40.0,),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        color: settingController.isDark.value? IColor().DARK_TOKEN_WIDGET_COLOR:IColor().LIGHT_TOKEN_WIDGET_COLOR,),
                      child: Column(
                        children: const [
                          Text(
                            "Anyone can create a token",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "including fake versions of existing tokens. Learn about scams and security risks.",
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height:16.0),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                              style:settingController.isDark.value? Themes.dark.elevatedButtonTheme.style:Themes.light.elevatedButtonTheme.style,
                                onPressed: () {
                                  controller.getTokenInfoByContractAddress(controller.contractAddressController.text);

                                  Get.back();
                                }, child: const Text("Save"))),
                      ],
                    ),
                    SizedBox(height: 10.0,)

                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
  onContractAddressSubmitted(String contractAddress){
    controller.contractAddressController.text = contractAddress;
    controller.getTokenName(contractAddress);
    controller.getTokenSymbol(contractAddress);
    controller.getTokenDecimal(contractAddress);
  }
}