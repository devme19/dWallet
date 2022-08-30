import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/setting_controller.dart';
class AssetsItemWidget extends StatefulWidget {
  AssetsItemWidget({
    Key? key,
    this.coin
  }) : super(key: key);
  CoinModel? coin;
  @override
  State<AssetsItemWidget> createState() => _AssetsItemWidgetState();
}

class _AssetsItemWidgetState extends State<AssetsItemWidget> {
  WalletController controller = Get.find();
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      Obx(()=>Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          color: settingController.isDark.value? IColor().DARK_TOKEN_WIDGET_COLOR:IColor().LIGHT_TOKEN_WIDGET_COLOR,),
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
                    child: Image.network(widget.coin!.imageUrl!),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          widget.coin!.name!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(widget.coin!.usd!=null?widget.coin!.usd!.toString():''),
                      )
                    ],
                  ),
                ],
              ),
              Switch(
                  activeTrackColor: IColor().Dark_CHECK_COLOR,
                  activeColor: IColor().DARK_TEXT_COLOR,
                  inactiveTrackColor: IColor().DARK_INPUT_COLOR,
                  inactiveThumbColor: IColor().DARK_TEXT_COLOR,
                  value: widget.coin!.enable!,
                  onChanged: (value) {
                    setState(() {
                      widget.coin!.enable = value;
                      controller.saveCoins();
                    });
                  })
            ],
          ),
        ),
      ));
  }
}
