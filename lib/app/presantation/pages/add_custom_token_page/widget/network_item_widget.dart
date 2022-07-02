import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
class NetworkItemWidget extends StatelessWidget {
  NetworkItemWidget({
    Key? key,
    this.coin,
    this.selectedNetwork,
    this.network
  }) : super(key: key);
  CoinModel? coin;
  ValueChanged<String>? selectedNetwork;
  String? network;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      InkWell(
        onTap: (){
          coin!.isSelected= !coin!.isSelected;
          selectedNetwork!(coin!.network!);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
          height: size.height * 0.11,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffF7931A)),
                      child: Image.network(coin!.imageUrl!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        coin!.network!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Transform.scale(
                  scale: 1.8,
                  child: Checkbox(
                      side: BorderSide(
                          width: 0.5,
                          color: Colors.transparent),
                      tristate: false,
                      activeColor: IColor().Dark_CHECK_COLOR.withOpacity(0.1),
                      checkColor: IColor().Dark_CHECK_COLOR,
                      splashRadius: 10,
                      value: network == coin!.network!,
                      onChanged: (value) {
                        coin!.isSelected= !coin!.isSelected;
                        selectedNetwork!(coin!.network!);
                      }),
                ),
                // Switch(
                //     activeTrackColor: IColor().Dark_CHECK_COLOR,
                //     activeColor: IColor().DARK_TEXT_COLOR,
                //     inactiveTrackColor: IColor().DARK_INPUT_COLOR,
                //     inactiveThumbColor: IColor().DARK_TEXT_COLOR,
                //     value: widget.coin!.isSelected,
                //     onChanged: (value) {
                //       setState(() {
                //         widget.coin!.isSelected = value;
                //       });
                //     })
              ],
            ),
          ),
        ),
      );
  }
}
