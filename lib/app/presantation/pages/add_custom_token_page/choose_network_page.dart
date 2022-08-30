import 'package:dwallet/app/data/models/network_model.dart';
import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/pages/add_custom_token_page/widget/network_item_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

class ChooseNetworkPage extends StatefulWidget {
  List<NetworkModel>? networks;
  ValueChanged<NetworkModel>? selectedNetwork;
  NetworkModel? network;
  ChooseNetworkPage({Key? key,this.networks,this.selectedNetwork,this.network}) : super(key: key);

  @override
  State<ChooseNetworkPage> createState() => _ChooseNetworkPageState();
}

class _ChooseNetworkPageState extends State<ChooseNetworkPage> {

  SettingController settingController = Get.find();
  List<NetworkModel> _filterNetworkList(String searchTerm) {
    return widget.networks!
        .where(
          (element) =>
      element.name!.toLowerCase().contains(searchTerm))
        .toList();
  }
  String? network;
  selectedNetwork(NetworkModel net)async{
    setState(() {
      widget.network = net;
    });

    await Future.delayed(const Duration(milliseconds: 400));
    Get.back();
    widget.selectedNetwork!(net);
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(16.0),
        height: Get.height * 0.8,
        decoration: BoxDecoration(
            color: settingController.isDark.value? IColor().DARK_HOME_LIST_BG_COLOR:IColor().LIGHT_HOME_LIST_BG_COLOR,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
        child:
        Column(
          children: [
            Expanded(
              child: SearchableList<NetworkModel>(

                // seperatorBuilder: (p0, p1) {
                //   return const Divider();
                // },

                initialList: widget.networks!,
                builder: (NetworkModel network) => NetworkItemWidget(network: network,networkStr: widget.network!.name,selectedNetwork: selectedNetwork),
                filter: _filterNetworkList,
                emptyWidget:  const Padding(padding: EdgeInsets.all(16.0),child: Center(child: Text("No Item")),),
                onItemSelected: (NetworkModel item) {},
                inputDecoration: InputDecoration(
                    filled: true,
                    // prefix: Icon(Icons.search),
                    fillColor: settingController.isDark.value?Color(0xff2C2C2E):Color(0xffE0E0E6),
                    hintText: 'Search',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:BorderSide.none

                    ),
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:BorderSide.none
                    )
                ),
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      );
  }
}

