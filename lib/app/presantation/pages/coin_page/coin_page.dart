import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/pages/coin_info_page/coin_info_page.dart';
import 'package:dwallet/app/presantation/pages/send_page/send_page.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../receive_page/receive_page.dart';

class CoinPage extends StatelessWidget {
  WalletController controller  = Get.find();
  SettingController settingController  = Get.find();
  CoinPage({Key? key}) : super(key: key){
    controller.getTransactions(controller.selectedCoin.transactions);
    if(controller.selectedCoin.contractAddress!= null){
      controller.getTokenBalance(controller.selectedCoin.contractAddress!, controller.selectedCoin, controller.selectedCoin.jrpcApi![0]);
    }
    else{
      controller.retryCount = 0;
      controller.getBalance(controller.selectedCoin.jrpcApi![0], controller.selectedCoin);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      Obx(()=>Container(

          padding: EdgeInsets.only(left: size.width * 0.033,right: size.width * 0.033,top: 16.0),
          height: size.height * 0.9,
          decoration: BoxDecoration(
              color: settingController.isDark.value? IColor().DARK_HOME_LIST_BG_COLOR:IColor().LIGHT_HOME_LIST_BG_COLOR,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child:
          GetBuilder<WalletController>(builder: (walletController){
            return ListView(
              children: [

                Row(
                  children: [
                    Expanded(
                      child:
                      InkWell(
                        onTap: ()=>Get.back(),
                        child: Text(
                          "Cancel",
                          style:
                          TextStyle(fontSize: 20, color: Get.theme.primaryColor),
                        ),
                      ),
                    ),
                    Text(
                      walletController.selectedCoin.name!,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                    ),

                    Expanded(
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.bottomSheet(
                                  isScrollControlled: true,
                                  CoinInfoPage(coin: walletController.selectedCoin,));
                            },
                            icon: Image.asset("assets/images/icons/info.png",color: Get.theme.primaryColor,),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30.0,),
                Row(
                  children: [
                    const Expanded(child:
                    SizedBox(
                        height: 250,
                        child: Text('COIN',style: TextStyle(fontWeight: FontWeight.bold),))),
                    Column(
                      children: [

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
// color: const Color(0xffF7931A)
                          ),
                          child:walletController.selectedCoin.imageUrl!.isEmpty?Image.asset('assets/images/crypto.png',color: Colors.white38,): Image.network(walletController.selectedCoin.imageUrl!),
                        ),
                        GetBuilder<WalletController>(builder: (walletController){
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              walletController.selectedCoin.balance!= null?walletController.selectedCoin.balance!.toStringAsFixed(2):"0",
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            (walletController.selectedCoin.usd!*walletController.selectedCoin.balance!).toStringAsFixed(2),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                        isScrollControlled: true,
                                        ReceivePage(
                                          coin: walletController.selectedCoin,));
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: IColor()
                                            .DARK_BUTTOM_COLOR
                                            .withOpacity(0.1)),
                                    child: Icon(
                                      Icons.arrow_downward,
                                      size: 35,
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 11),
                                  child: Text(
                                    "Receive",
                                    style: TextStyle(color: Get.theme.primaryColor,fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                        isScrollControlled: true,
                                        SendPage(
                                          coin: walletController.selectedCoin,)).then((value) {
                                      Future.delayed(Duration(seconds: 4)).then((value) {
                                        controller.getTransactions(walletController.selectedCoin.transactions);
                                        if(walletController.selectedCoin.contractAddress!= null){
                                          controller.getTokenBalance(walletController.selectedCoin.contractAddress!, walletController.selectedCoin, walletController.selectedCoin.jrpcApi![0]);
                                        }
                                        else{
                                          controller.getBalance(walletController.selectedCoin.jrpcApi![0], walletController.selectedCoin);
                                        }
                                      });

                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: IColor()
                                            .DARK_BUTTOM_COLOR
                                            .withOpacity(0.1)),
                                    child: Icon(
                                      Icons.arrow_upward,
                                      size: 35,
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 11),
                                  child: Text(
                                    "Send",
                                    style: TextStyle(color: Get.theme.primaryColor,fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),

                    Expanded(child:
                    SizedBox(
                        height: 250,
                        child:
                        walletController.selectedCoin.usd24hChange!=null?
                        Text(
                          "${double.parse((walletController.selectedCoin.usd24hChange)!.toStringAsFixed(2))}% - 1D",
                          style: TextStyle(color:walletController.selectedCoin.usd24hChange!>0? IColor().Dark_CHECK_COLOR:Colors.red),
                          textAlign: TextAlign.right,
                        ):Container()
                    ))
                  ],
                ),
                Row(children: [
                  Text(
                    walletController.selectedCoin.usd!= null?'@ \$${walletController.selectedCoin.usd!}':"0",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],),
                const SizedBox(height: 10.0,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Divider(color: Colors.white),
                ),
                Obx(()=>Column(children: [
                  ...controller.transactions.reversed
                ],),)
              ],
            );
          })
      ));
  }
}
