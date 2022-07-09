import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/input_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendPage extends StatefulWidget {
  SendPage({
    Key? key,
    this.coin
  }) : super(key: key);
  CoinModel? coin;
  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  TextEditingController amountController = TextEditingController();
  String usdValue="0";
  onAmountChange(String value){
    setState(() {
      usdValue = (widget.coin!.usd!*double.parse(value)).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return 
      
      SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
        height: size.height * 0.8,
        decoration: BoxDecoration(
            color: IColor().DARK_BG_COLOR,
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
                          "Send ${widget.coin!.symbol!}",
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
                  const SizedBox(height: 16.0,),
                  // InkWell(
                  //   child: Container(
                  //     padding: const EdgeInsets.all(15),
                  //     margin: const EdgeInsets.only(bottom: 8),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8),
                  //         color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         const Text(
                  //           "Network",
                  //           style: TextStyle(fontSize: 18),
                  //         ),
                  //         Row(
                  //           children: [
                  //             Text(
                  //               "Bitcoin",
                  //               style: TextStyle(
                  //                   color:
                  //                       IColor().DARK_TEXT_COLOR.withOpacity(0.5),
                  //                   fontSize: 18),
                  //             ),
                  //             Icon(
                  //               Icons.arrow_forward,
                  //               color: IColor().DARK_TEXT_COLOR.withOpacity(0.5),
                  //               size: 20,
                  //             )
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: InputWidget(hint: "Recipient Address"),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 65,
                          height: 65,
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
                          child: Image.asset("assets/images/icons/paste.png"),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 65,
                          height: 65,
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
                          child: Image.asset("assets/images/icons/scan.png"),
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
                          child: InputWidget(hint: "Amount",controller: amountController,onChange: onAmountChange),
                        ),
                        InkWell(
                          onTap: () {
                            amountController.text = widget.coin!.balance!.toString();
                            onAmountChange(amountController.text);
                          },
                          child: Container(
                            width: 65,
                            height: 65,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: IColor()
                                    .DARK_BUTTOM_COLOR
                                    .withOpacity(0.1)),
                            child: Text(
                              "MAX",
                              style: TextStyle(
                                  color: IColor().DARK_PRIMARY_COLOR,
                                  fontWeight: FontWeight.bold),
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
                        child: Text('\$$usdValue'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
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
                            onPressed: () {}, child: Text("Send"))),
                  ],
                )
              ],
            )
          ],
        ),
    ),
      );
  }
}
