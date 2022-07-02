import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/pages/add_custom_token_page/choose_network_page.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/input_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCustomTokenPage extends GetView<WalletController> {
  AddCustomTokenPage({Key? key}) : super(key: key){
    controller.contractAddressController.clear();
    controller.tokenDecimalController.clear();
    controller.tokenSymbolController.clear();
    controller.tokenNameController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.033),
        height: Get.height * 0.9,
        decoration: BoxDecoration(
            color: IColor().DARK_BG_COLOR,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: IColor().DARK_TEXT_COLOR),
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
                                fontSize: 18, color: IColor().DARK_PRIMARY_COLOR),
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
                            color: IColor().DARK_TEXT_COLOR,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                InkWell(
                  onTap: (){
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: Get.context!,
                        builder: (context) {
                          return ChooseNetworkPage(networks: controller.coins,selectedNetwork: controller.onNetworkChange,network: controller.network.value,);
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Network",
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: [
                            Obx(()=>Text(
                              controller.network.value,
                              style: TextStyle(
                                  color:
                                  IColor().DARK_TEXT_COLOR.withOpacity(0.5),
                                  fontSize: 18),
                            ),),
                            Icon(
                              Icons.arrow_forward,
                              color: IColor().DARK_TEXT_COLOR.withOpacity(0.5),
                              size: 20,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
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
                            borderRadius: BorderRadius.circular(8),
                            color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
                        child: Image.asset("assets/images/icons/paste.png"),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
                        child: Image.asset("assets/images/icons/scan.png"),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(hint: "Name",controller: controller.tokenNameController,),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(hint: "Symbol",controller: controller.tokenSymbolController,),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(hint: "Decimal",controller: controller.tokenDecimalController,),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
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
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              controller.getTokenInfoByContractAddress(controller.contractAddressController.text);
                            }, child: const Text("Add"))),
                  ],
                ),
                const SizedBox(height: 16.0,),
              ],
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