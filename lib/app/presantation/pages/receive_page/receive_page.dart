import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ReceivePage extends GetView<WalletController> {
  ReceivePage({Key? key,this.coin}) : super(key: key){
    controller.getEthereumAddress();
  }
  CoinModel? coin;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.033),
        height: Get.height * 0.8,
        decoration: BoxDecoration(
            color: IColor().DARK_BG_COLOR,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
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
                        "Receive ${coin!.symbol!}",
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
              ],
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                children: [

                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.only(top: 2,right: 2,left: 0,bottom: 0),
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
                        color: Colors.white,
                        // border: Border(top: BorderSide(width: 3,color: Colors.white),right: BorderSide(width: 3,color: Colors.white))
                      ),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(16)),
                          color: IColor().DARK_BG_COLOR.withOpacity(1),
                          // border: Border(top: BorderSide(width: 3,color: Colors.white),right: BorderSide(width: 3,color: Colors.white))
                        ),

                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 2,left: 2),
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16)),
                        color: Colors.white,
                        // border: Border(top: BorderSide(width: 3,color: Colors.white),right: BorderSide(width: 3,color: Colors.white))
                      ),
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: const Radius.circular(16)),
                          color: IColor().DARK_BG_COLOR,
                          // border: Border(top: BorderSide(width: 3,color: Colors.white),right: BorderSide(width: 3,color: Colors.white))
                        ),

                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2,right: 2),
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(16)),
                        color: Colors.white,
                        // border: Border(top: BorderSide(width: 3,color: Colors.white),right: BorderSide(width: 3,color: Colors.white))
                      ),
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: const Radius.circular(16)),
                          color: IColor().DARK_BG_COLOR,
                          // border: Border(top: BorderSide(width: 3,color: Colors.white),right: BorderSide(width: 3,color: Colors.white))
                        ),

                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2,left: 2),
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16)),
                        color: Colors.white,
                        // border: Border(top: BorderSide(width: 3,color: Colors.white),right: BorderSide(width: 3,color: Colors.white))
                      ),
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(16)),
                          color: IColor().DARK_BG_COLOR,
                          // border: Border(top: BorderSide(width: 3,color: Colors.white),right: BorderSide(width: 3,color: Colors.white))
                        ),

                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.all(7),
                      child: QrImage(
                        // backgroundColor: Colors.white,
                        foregroundColor: Colors.white,
                        data: controller.ethAddress.value,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Get.theme.primaryColorDark.withOpacity(0.1)
              ),
                child: Text('${controller.ethAddress.value.substring(0,6)}..${controller.ethAddress.value.substring(controller.ethAddress.value.length-4,controller.ethAddress.value.length)}',style: const TextStyle(color: Colors.white),)),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                InkWell(
                  onTap: (){
                    Clipboard.setData(ClipboardData(text: controller.ethAddress.value));
                    Fluttertoast.showToast(msg: "copied to clipboard");
                  },
                  child: Row(
                    children: [
                      Text('Copy',style: TextStyle(color: Get.theme.primaryColor),),
                      SizedBox(width: 8.0,),
                      Image.asset('assets/images/icons/copy.png')
                    ],
                  ),
                ),
                SizedBox(width: 35.0,),
                InkWell(
                  onTap: (){
                    print("share");
                    Share.share(controller.ethAddress.value,subject: 'share contract address');
                  },
                  child: Row(
                    children: [
                      Text('Share',style: TextStyle(color: Get.theme.primaryColor),),
                      SizedBox(width: 8.0,),
                      Image.asset('assets/images/icons/share.png')
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: 40.0,),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffFF453A).withOpacity(0.13)),
              child: Column(
                children: const [
                  Text(
                    "You can’t undo this transfer",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Color(0xffFF453A)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "if you mistakenly send your crypto to wrong address, you will lost your funds.",
                    style: TextStyle(fontSize: 13,color: Color(0xffFF453A),height: 1.5),

                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
