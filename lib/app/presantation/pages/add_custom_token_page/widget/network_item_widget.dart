import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/data/models/network_model.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/setting_controller.dart';
class NetworkItemWidget extends StatelessWidget {
  NetworkItemWidget({
    Key? key,
    this.network,
    this.selectedNetwork,
    this.networkStr
  }) : super(key: key);
  NetworkModel? network;
  ValueChanged<NetworkModel>? selectedNetwork;
  String? networkStr;
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      InkWell(
        onTap: (){
          selectedNetwork!(network!);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
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
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xffF7931A)),
                      child: Image.network(network!.imageUrl!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        network!.name!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Transform.scale(
                  scale: 1.8,
                  child: Checkbox(
                      side: const BorderSide(
                          width: 0,
                          color: Colors.transparent),
                      tristate: false,
                      activeColor: Colors.transparent,
                      checkColor: IColor().Dark_CHECK_COLOR,
                      splashRadius: 10,
                      value: networkStr == network!.name!,
                      onChanged: (value) {
                        network!.isSelected= !network!.isSelected;
                        selectedNetwork!(network!);
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
