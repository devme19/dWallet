import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/search_item_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../controllers/wallet_controller.dart';


class SearchCoinWidget extends GetView<WalletController> {
  SearchCoinWidget({Key? key, required this.title,this.selectedCoin}) : super(key: key);
  String? title;
  ValueChanged<CoinModel>? selectedCoin;
  List<CoinModel> _filterCoinsList(String searchTerm) {
    return controller.coins
        .where(
            (element) =>
            element.name!.toLowerCase().contains(searchTerm))
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: IColor().DARK_BG_COLOR,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      alignment: Alignment.bottomCenter,
      height: size.height * 0.74,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
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
                            fontSize: 20, color: IColor().DARK_PRIMARY_COLOR),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: IColor().DARK_TEXT_COLOR,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
          ),
          Expanded(
            child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchableList<CoinModel>(
                initialList: controller.coins,
                builder: (CoinModel coin) => SearchItemWidget(coin:coin),
                filter: _filterCoinsList,
                emptyWidget:  const Padding(padding: EdgeInsets.all(16.0),child: Center(child: Text("No Item")),),
                onItemSelected: (CoinModel item) {
                  print(item.name);
                  selectedCoin!(item);
                },
                inputDecoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20.0),
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
          ),
          // Expanded(
          //   child: Container(
          //     margin: EdgeInsets.only(top: 8),
          //     child: ListView.builder(
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 10,
          //         ),
          //         itemCount: controller.coins.length,
          //         itemBuilder: (context, index) => SearchItemWidget(coin: controller.coins[index],)),
          //   ),
          // )
        ],
      ),
    );
  }
}
