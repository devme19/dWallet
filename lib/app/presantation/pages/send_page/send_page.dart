import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/input_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:dwallet/app/web3/web3dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class SendPage extends GetView<WalletController> {
  SendPage({
    Key? key,
    this.coin,
    this.onBack
  }) : super(key: key){
    controller.usdValue.value ="";
  }
  CoinModel? coin;
  ValueChanged<TransactionInformation>? onBack;
  TextEditingController amountController = TextEditingController();
  TextEditingController recipientController = TextEditingController();
  String usdValue="0";
  final _formKey = GlobalKey<FormState>();
  SettingController settingController = Get.find();
  bool isNumeric(String s) {
    if (s.isEmpty) {
      return false;
    }
    return double.tryParse(s) != null;
  }
  onAmountChange(String value){
    if(isNumeric(value)) {
      controller.usdValue.value = (coin!.usd!*double.parse(value)).toStringAsFixed(2);
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(()=>
        Form(
          key: _formKey,
          child: SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
          height: size.height * 0.8,
          decoration: BoxDecoration(
              color: settingController.isDark.value? IColor().DARK_HOME_LIST_BG_COLOR:IColor().LIGHT_HOME_LIST_BG_COLOR,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(
                child: Column(
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
                            "Send ${coin!.symbol!}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                    const SizedBox(height: 16.0,),
                    Row(
                      children: [
                        Expanded(
                          child: InputWidget(hint: "Recipient Address",controller: recipientController,),
                        ),
                        InkWell(
                          onTap: () async{
                            ClipboardData? cData = await Clipboard.getData(Clipboard.kTextPlain);
                            if(cData != null){
                              String? copiedText = cData.text;
                              if(copiedText!= null){
                                recipientController.text = copiedText;
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color:settingController.isDark.value?Color(0xff636366): Color(0xff636366)),
                                color:settingController.isDark.value?Color(0xff2C2C2E): Color(0xffE0E0E5)),
                            child: Image.asset("assets/images/icons/paste.png",height: 20,width: 20,color:Get.theme.primaryColor),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color:settingController.isDark.value?Color(0xff636366): Color(0xff636366)),
                                color:settingController.isDark.value?Color(0xff2C2C2E): Color(0xffE0E0E5)),
                            child: Image.asset("assets/images/icons/scan.png",height: 20,width: 20,color:Get.theme.primaryColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0,),
                    SizedBox(
                      height: 70,
                      child:
                      Row(
                        children: [
                          Expanded(
                            child: InputWidget(hint: "Amount",controller: amountController,onChange: onAmountChange,isNumberMode: true),
                          ),
                          InkWell(
                            onTap: () {
                              amountController.text = coin!.balance!.toString();
                              onAmountChange(amountController.text);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color:settingController.isDark.value?Color(0xff636366): Color(0xff636366)),
                                  color:settingController.isDark.value?Color(0xff2C2C2E): Color(0xffE0E0E5)),
                              child: FittedBox(
                                child: Text(
                                  "MAX",
                                  style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),

                        ],

                      ),

                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.usdValue.value!=''?'\$${controller.usdValue.value}':''),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      color: settingController.isDark.value? IColor().DARK_TOKEN_WIDGET_COLOR:IColor().LIGHT_TOKEN_WIDGET_COLOR,),

                    child: Column(
                      children: const [
                        Text(
                          "You can’t undo this transfer",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "if you mistakenly send your crypto to wrong address, you will lost your funds.",
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
                            style:settingController.isDark.value? Themes.dark.elevatedButtonTheme.style:Themes.light.elevatedButtonTheme.style,
                              onPressed: () {
                                if(_formKey.currentState!.validate()){
                                  controller.retryCount = 0;
                                  controller.sendTransaction(receiveAddress: recipientController.text,amount: double.parse(amountController.text),coin: coin);
                                }

                              }, child: Text("Send"))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
      ),
    ),
        ));
  }

}