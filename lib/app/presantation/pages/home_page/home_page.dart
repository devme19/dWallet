import 'package:dwallet/app/data/models/coin_model.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/pages/add_custom_token_page/add_custom_token_page.dart';
import 'package:dwallet/app/presantation/pages/coin_page/coin_page.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/bg_widget.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/search_coin_widget.dart';
import 'package:dwallet/app/presantation/pages/global_widgets/success_dialog.dart';
import 'package:dwallet/app/presantation/pages/home_page/widget/token_item_widget.dart';
import 'package:dwallet/app/presantation/pages/send_page/send_page.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:path/path.dart';
class HomePage extends GetView<WalletController> {
  HomePage({Key? key}) : super(key: key){
    controller.loadCoins();
  }
  TextEditingController searchController= TextEditingController();
  double top =0.0;
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child:
          Scaffold(
              backgroundColor: Colors.transparent,
              body:
              LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  color: Themes.dark.primaryColor,
                  springAnimationDurationInMilliseconds: 300,
                  height: 60,
                  onRefresh: onRefresh,
                  child: BgWidget(child: body()))
          ),
      );
  }

  Future<void> onRefresh()async=>
    controller.loadCoins();
  Widget body(){
    return GetBuilder<WalletController>(builder: (controller){
      return
      CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor:Colors.transparent,
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            actions: [
              IconButton(
                  onPressed: () {
                    controller.visibleSearchBar();
                  },
                  icon: Image.asset("assets/images/icons/search.png"))
            ],
            leading: IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/icons/setting.png")),
            flexibleSpace:
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints)
                {
                  top = constraints.biggest.height;
                  if(top<150){
                    visibility = false;
                    controller.visibility.value = false;
                  }
                  else{
                    visibility = true;
                    controller.visibility.value = true;
                  }
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: SizedBox(
                      height: 125,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "\$${controller.totalBalance.toStringAsFixed(2)}",
                              style: Themes.dark.textTheme.headline1,
                            ),
                          ),
                          Visibility(
                            visible: visibility,
                            child:
                            SizedBox(
                              height: 90,
                              child: Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [

                                        InkWell(
                                          onTap: () {
                                            print("Receive");

                                          },
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(40),
                                                color: IColor()
                                                    .DARK_BUTTOM_COLOR
                                                    .withOpacity(0.1)),
                                            child: const Icon(
                                              Icons.arrow_downward,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8.0,),
                                        Expanded(
                                          child: Text(
                                            "Receive",
                                            style: Themes.dark.textTheme.subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // controller.sendTransaction(apiUrl: '',amount: 0.002,receiveAddress: );
                                            // showModalBottomSheet<void>(
                                            //     context: context,
                                            //     isScrollControlled: true,
                                            //     backgroundColor: Colors.transparent,
                                            //     builder: (BuildContext context) {
                                            //       return SearchCoinWidget(title: 'Send',);
                                            //     });
                                            Get.bottomSheet(
                                              isScrollControlled: true,
                                                SearchCoinWidget(title: 'Send',selectedCoin: onCoinSelected,));
                                          },
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(40),
                                                color: IColor()
                                                    .DARK_BUTTOM_COLOR
                                                    .withOpacity(0.1)),
                                            child: const Icon(
                                              Icons.arrow_upward,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8.0,),
                                        Expanded(
                                          child: Text(
                                            "Send",
                                            style: Themes.dark.textTheme.subtitle2,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )

                          // TextButton(onPressed: (){}, child: Text("sdsd"))
                        ],
                      ),
                    ),
                    // background: Image.network(
                    //   "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    //   fit: BoxFit.cover,
                    // )
                  );
                }),
          ),
          SliverToBoxAdapter(
              child:
              Container(
                padding: const EdgeInsets.only(bottom: 20.0,right: 8.0,left: 8.0),
                // margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: IColor().DARK_HOME_LIST_BG_COLOR,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )
                ),
                child: Column(children: [
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Assets",
                          style: TextStyle(
                              fontSize: 20, color: IColor().DARK_TEXT_COLOR),
                        ),
                        InkWell(
                          onTap: () {

                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: Get.context!,
                                builder: (context) {
                                  return AddCustomTokenPage();
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: IColor()
                                    .DARK_PRIMARY_COLOR
                                    .withOpacity(0.2)),
                            child: Image.asset("assets/images/icons/add-asset.png"),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.searchVisibility,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10,right:10,top: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: IColor()
                              .DARK_BUTTOM_COLOR
                              .withOpacity(0.1)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8, bottom: 8),
                            child: Icon(
                              Icons.search,
                              color: IColor().DARK_TEXT_COLOR,
                            ),
                          ),
                          Expanded(
                              child: TextField(
                                controller: searchController,
                                onSubmitted: (value) {
                                  controller.invisibleSearchBar();
                                },
                                onChanged: controller.searchCoin,
                                autofocus: true,
                                textAlignVertical: TextAlignVertical.bottom,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.withOpacity(0.6),
                                    ),
                                    fillColor: Colors.transparent,
                                    hintText: "Search"),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],),
              )),
          GetBuilder<WalletController>(builder: (walletController){
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return
                    InkWell(
                      onTap: ()
                      {
                        Get.bottomSheet(
                            isScrollControlled: true,
                            CoinPage(
                              coin: walletController.filteredCoins[index],));
                        controller.clearSearch();
                        searchController.clear();
                      },
                      child: TokenItemWidget(
                        coin: walletController.filteredCoins[index],
                      ),
                    );
                },
                childCount: walletController.filteredCoins.length,
              ),
            );
          })
        ],
      );
    });
  }

  onCoinSelected(CoinModel coin){
    Get.back();
    Get.bottomSheet(
        isScrollControlled: true,
        SendPage(coin: coin,));
  }
}
