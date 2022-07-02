import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/pages/add_custom_token_page/widget/assets_item_widget.dart';
import 'package:dwallet/app/presantation/pages/add_custom_token_page/widget/network_item_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

class ChooseNetworkPage extends StatefulWidget {
  List<CoinModel>? networks;
  ValueChanged<String>? selectedNetwork;
  String? network;
  ChooseNetworkPage({Key? key,this.networks,this.selectedNetwork,this.network}) : super(key: key);

  @override
  State<ChooseNetworkPage> createState() => _ChooseNetworkPageState();
}

class _ChooseNetworkPageState extends State<ChooseNetworkPage> {
  List<CoinModel> _filterUserList(String searchTerm) {
    return widget.networks!
        .where(
          (element) =>
      element.network!.toLowerCase().contains(searchTerm))
        .toList();
  }
  String? network;
  selectedNetwork(String net)async{
    setState(() {
      widget.network = net;
    });

    await Future.delayed(Duration(milliseconds: 400));
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
            color: IColor().DARK_BG_COLOR,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
        child:
        Column(
          children: [
            Expanded(
              child: SearchableList<CoinModel>.seperated(

                seperatorBuilder: (p0, p1) {
                  return const Divider();
                },

                initialList: widget.networks!,
                builder: (CoinModel coin) => NetworkItemWidget(coin: coin,network: widget.network,selectedNetwork: selectedNetwork),
                filter: _filterUserList,
                emptyWidget:  const Padding(padding: EdgeInsets.all(16.0),child: Center(child: Text("No Item")),),
                onItemSelected: (CoinModel item) {},
                inputDecoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    fillColor:  IColor().DARK_BUTTOM_COLOR.withOpacity(0.1),
                    hintText: "Search"),
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      );
  }
}

