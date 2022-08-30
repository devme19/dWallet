import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/search_item_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../controllers/wallet_controller.dart';


class SearchCoinWidget extends GetView<WalletController> {
  SearchCoinWidget({Key? key, required this.title,this.selectedCoin}) : super(key: key);
  String? title;
  SettingController settingController = Get.find();
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
          color: settingController.isDark.value? IColor().DARK_HOME_LIST_BG_COLOR:IColor().LIGHT_HOME_LIST_BG_COLOR,
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
                color: settingController.isDark.value?Colors.white54:Colors.black54),
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
                            fontSize: 20, color: Get.theme.primaryColor),
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
