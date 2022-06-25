import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
      height: size.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: IColor().Dark_CHECK_COLOR.withOpacity(0.2),
                  ),
                  child: Text(
                    'hightPrice!',
                    style: TextStyle(color: IColor().Dark_CHECK_COLOR),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child:
                  Column(
                    children: [

                      Text(coin!.balance.toString() + ' '+ coin!.symbol!),
                      Text(
                        '\$${(coin!.balance!*coin!.usd!).toStringAsFixed(2)}',
                        style: Themes.dark.textTheme.headline1,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: IColor().Dark_CHECK_COLOR.withOpacity(0.2),
                  ),
                  child: Text(
                    'chart!',
                    style: TextStyle(color: IColor().Dark_CHECK_COLOR),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
