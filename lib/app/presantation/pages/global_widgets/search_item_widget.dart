import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';

class SearchItemWidget extends StatelessWidget {
  SearchItemWidget({
    Key? key,
    this.coin
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
      height: size.height * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffF7931A)),
                      child: Image.network(coin!.imageUrl!),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                coin!.name!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 8.0,),
                              Text(
                                 coin!.symbol!,
                                style: TextStyle(
                                    fontSize: 16,color:IColor().DARK_BUTTOM_COLOR.withOpacity(0.3), fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text((coin!.usd! * coin!.balance!).toStringAsFixed(2)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                     coin!.balance!.toStringAsFixed(2),
                      style: TextStyle(color: IColor().DARK_TEXT_COLOR.withOpacity(0.8)),
                    ),
                    const SizedBox(width: 8.0,),
                    Text(
                      coin!.symbol!,
                      style: TextStyle(
                          fontSize: 16,color:IColor().DARK_TEXT_COLOR.withOpacity(0.8)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
