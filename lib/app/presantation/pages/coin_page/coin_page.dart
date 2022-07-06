import 'dart:ui';

import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/data/models/transaction_model.dart';
import 'package:dwallet/app/presantation/pages/coin_page/widgets/transaction_widget_item.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';

class CoinPage extends StatefulWidget {
  CoinPage({Key? key, this.coin}) : super(key: key);

  CoinModel? coin;

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  List txs = [
    TransactionModel(
        date: "today",
        txId: "asfaefnolsdgva;wwemdfc",
        isSend: true,
        amount: 22,
        symbol: "ETH"),
    TransactionModel(
        date: "yesterday",
        txId: "adwdawdwad;wwemdfc",
        isSend: false,
        amount: 32.4,
        symbol: "BTC"),
    TransactionModel(
        date: "yesterday",
        txId: "asfaefnolsdgva;wwemdfc",
        isSend: true,
        amount: 12,
        symbol: "BNB"),
    TransactionModel(
        date: "Last week",
        txId: "af'ala,ewfwmpaw;wwemdfc",
        isSend: false,
        amount: 111,
        symbol: "BTC")
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
      height: size.height * 0.9,
      decoration: BoxDecoration(
          color: IColor().DARK_BG_COLOR,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(fontSize: 20, color: IColor().DARK_PRIMARY_COLOR),
                ),
              ),
              Text(
                widget.coin!.name!,
                style: Themes.dark.textTheme.headline1,
              ),
              
              Expanded(
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/images/icons/info.png"),
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
                  child: Text('COIN'))),
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
                    child:widget.coin!.imageUrl!.isEmpty?Image.asset('assets/images/crypto.png',color: Colors.white38,): Image.network(widget.coin!.imageUrl!),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.coin!.balance!= null?widget.coin!.balance!.toString():"0",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      (widget.coin!.usd!*widget.coin!.balance!).toStringAsFixed(2),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: IColor()
                                      .DARK_BUTTOM_COLOR
                                      .withOpacity(0.1)),
                              child: const Icon(
                                Icons.arrow_downward,
                                size: 35,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            child: Text(
                              "Receive",
                              style: Themes.dark.textTheme.bodyText1,
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
                            onTap: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: IColor()
                                      .DARK_BUTTOM_COLOR
                                      .withOpacity(0.1)),
                              child: const Icon(
                                Icons.arrow_upward,
                                size: 35,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 11),
                            child: Text(
                              "Send",
                              style: Themes.dark.textTheme.bodyText1,
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
                  Text(
                    "${widget.coin!.usd24hChange!>0?"+":"-"} ${double.parse((widget.coin!.usd24hChange)!.toStringAsFixed(2))}% - 1D",
                    style: TextStyle(color: IColor().Dark_CHECK_COLOR),
                    textAlign: TextAlign.right,
                  )
              ))
            ],
          ),
          Row(children: [
            Text(
              widget.coin!.usd!= null?'@ \$${widget.coin!.usd!}':"0",
              style: const TextStyle(fontSize: 16),
            ),
          ],),
          const SizedBox(height: 10.0,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Divider(color: Colors.white),
          )
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
          //   child: Row(
          //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     // crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Expanded(
          //         child: Text(
          //           "COIN",
          //           style: TextStyle(color: Colors.grey, fontSize: 18),
          //         ),
          //       ),
          //       Container(
          //         decoration: const BoxDecoration(
          //           shape: BoxShape.circle,
          //         ),
          //         child: Image.asset(
          //           widget.coin!.imageUrl!,
          //           fit: BoxFit.scaleDown,
          //         ),
          //       ),
          //       Expanded(
          //         child: Text(
          //           "+${widget.coin!.usd24hChange}% - 1D",
          //           style: TextStyle(color: IColor().Dark_CHECK_COLOR),
          //           textAlign: TextAlign.right,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Column(
          //   children: [
          //     const Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Text(
          //         "325,231,213 BTC",
          //         style: TextStyle(fontSize: 16),
          //       ),
          //     ),
          //     const Padding(
          //       padding: EdgeInsets.only(bottom: 8.0),
          //       child: Text(
          //         "\$5932.3",
          //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 5),
          //       child:


          //     Row(
          //       children: [Text("\$${widget.coin!.usd}")],
          //     ),
          //     const Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Divider(
          //         thickness: 1.2,
          //       ),
          //     ),
          //     SizedBox(
          //       height: size.height * 0.4,
          //       child: ListView.builder(
          //         itemCount: txs.length,
          //         itemBuilder: (context, index) =>
          //             TransactionWidgetItem(tx: txs[index]),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
