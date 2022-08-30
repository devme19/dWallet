import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/controllers/wallet_controller.dart';
import 'package:dwallet/app/presantation/pages/add_custom_token_page/add_custom_token_page.dart';
import 'package:dwallet/app/presantation/pages/assets_page/widgets/assets_item_widget.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AssetPage extends GetView<WalletController> {
  AssetPage({Key? key}) : super(key: key){
    controller.filteredCoins = controller.coins;
  }
  TextEditingController searchController= TextEditingController();
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      Obx(()=>Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Container(
          decoration: BoxDecoration(
              color: settingController.isDark.value? IColor().DARK_HOME_LIST_BG_COLOR:IColor().LIGHT_HOME_LIST_BG_COLOR,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30))),
          alignment: Alignment.bottomCenter,
          height: size.height * 0.78,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Assets",
                      style: TextStyle(
                          fontSize: 20, color:settingController.isDark.value? IColor().DARK_TEXT_COLOR:IColor().LIGHT_TEXT_COLOR,fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        ShowAddCustomTokenPage();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:settingController.isDark.value? IColor()
                                .DARK_PRIMARY_COLOR
                                .withOpacity(0.2):IColor()
                                .LIGHT_PRIMARY_COLOR
                                .withOpacity(0.2)),
                        child: Text(
                          "+ Custom",
                          style: TextStyle(
                              fontSize: 20,
                              color: settingController.isDark.value? IColor()
                                  .DARK_PRIMARY_COLOR
                                  :IColor()
                                  .LIGHT_PRIMARY_COLOR,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10,right:10,top: 16),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: IColor()
                        .DARK_BUTTOM_COLOR
                        .withOpacity(0.1)),
                child: Row(
                  children: [
                    Expanded(
                        child:
                        TextField(
                          controller: searchController,
                          onChanged: controller.searchCoin,
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.bottom,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              filled: true,
                              prefix: Icon(Icons.search),
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
                          // decoration: InputDecoration(
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(20.0),
                          //     ),
                          //   enabledBorder: InputBorder.none,
                          //     disabledBorder: InputBorder.none,
                          //   focusedBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20.0),
                          //   ),
                          //   filled: true,
                          //   fillColor: settingController.isDark.value?Colors.red:IColor().LIGHT_BUTTON_COLOR,
                          //   prefix: Icon(Icons.search),
                          //     hintStyle: TextStyle(
                          //       fontSize: 18,
                          //       color: Colors.grey.withOpacity(0.6),
                          //     ),
                          //     hintText: "Search"),
                        ),

                        ),
                  ],
                ),
              ),
              GetBuilder<WalletController>(builder: (controller){
                return
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          itemCount: controller.filteredCoins.length,
                          itemBuilder: (context, index) =>
                              AssetsItemWidget(coin: controller.filteredCoins[index],)),
                    ),
                  );})
            ],
          ),
        ),
      ));
  }
  ShowAddCustomTokenPage() {
    Get.bottomSheet(
        isScrollControlled: true,
        AddCustomTokenPage());
    // showModalBottomSheet(
    //     backgroundColor: Colors.transparent,
    //     isScrollControlled: true,
    //     context: context,
    //     builder: (context) {
    //       return AddCustomTokenPage();
    //     });
  }
}
