import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../data/models/coin_model.dart';

class TokenItemWidget extends StatelessWidget {
  TokenItemWidget({
    Key? key,
    this.coin,
  }) : super(key: key);
  CoinModel? coin;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5,),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
      height: 160,
      child:
          Column(children: [
            
            Expanded(
              child: Row(
                children: [

                  Expanded(
                    child:
                    Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: const Color(0xffF7931A)
                        ),
                        child: Image.network(coin!.imageUrl!),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            coin!.name!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(coin!.usd!.toString()),
                        )
                      ],)
                    ],
                ),
                  ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: IColor().Dark_CHECK_COLOR.withOpacity(0.2),
                      ),
                      child:
                      Text(
                        'hightPrice!',
                        style: TextStyle(color: IColor().Dark_CHECK_COLOR),
                      ),
                    ),
                  ],
                ),
              ],),
            ),
            Expanded(
              child: Row(
                children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(
                          children: [
                            Text(coin!.balance.toString() + ' '+ coin!.symbol!),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\$${(coin!.balance!*coin!.usd!).toStringAsFixed(2)}',
                              style: Themes.dark.textTheme.headline1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: IColor().Dark_CHECK_COLOR.withOpacity(0.2),
                      ),
                      child: Text(
                        'chart!',
                        style: TextStyle(color: IColor().Dark_CHECK_COLOR),
                      ),
                    ),
                  ],
                ),
              ],),
            )
          ],),

    );
  }
}
