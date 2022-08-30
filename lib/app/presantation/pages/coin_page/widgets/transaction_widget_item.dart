import 'package:dwallet/app/data/models/transaction_model.dart';
import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
class TransactionWidgetItem extends StatelessWidget {
  TransactionWidgetItem({Key? key, this.tx}) : super(key: key);
  TransactionModel? tx;

  @override
  Widget build(BuildContext context) {
    return
      tx==null?Container():
      InkWell(
        onTap: (){
          Clipboard.setData(ClipboardData(text: tx!.txHash));
          Fluttertoast.showToast(msg: 'transaction hash copied to clipboard');
        },
        child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(tx!.date==null?'':getDateTime(tx!.date!),style: const TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
          TransactionWidget(
            tx: tx!,
          ),

          // const Padding(
          //   padding: EdgeInsets.only(left: 8, right: 8, bottom: 0),
          //   child: Divider(
          //     thickness: 1.2,
          //   ),
          // ),
        ],
    ),
      );
  }
  String getDateTime(String dateTime){
    DateTime now = DateTime.now();
    DateTime transactionDateTime = DateTime.parse(dateTime);
    final difference = now.difference(transactionDateTime).inDays;
    if(difference == 0){
      return "Today";
    }
    else if(difference == 1){
      return "Yesterday";
    }
    else {
      return DateFormat.yMMMEd().format(transactionDateTime);
    }
  }
}

class TransactionWidget extends StatelessWidget {
  TransactionWidget({Key? key, required this.tx}) : super(key: key);

  TransactionModel tx;
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0,top: 6.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: settingController.isDark.value? IColor().DARK_TOKEN_WIDGET_COLOR:IColor().LIGHT_TOKEN_WIDGET_COLOR,),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 1, color: settingController.isDark.value?Colors.white:Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Icon(
                        tx.isSend! ? Icons.arrow_upward : Icons.arrow_downward,color: Get.theme.primaryColor),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.isSend! ? "Send" : "Receive",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8.0,),
                    SizedBox(
                      width: 200,
                      child: Text(
                        "To: ${tx.txHash}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  tx.amount.toString(),
                  style: TextStyle(
                      color: tx.isSend!
                          ? IColor().DARK_WARNING_COLOR
                          : IColor().Dark_CHECK_COLOR),
                ),
                Text(tx.symbol!,
                    style: TextStyle(
                        color: tx.isSend!
                            ? IColor().DARK_WARNING_COLOR
                            : IColor().Dark_CHECK_COLOR))
              ],
            )
          ],
        ),
      ),
    );
  }
}
