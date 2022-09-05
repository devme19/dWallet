import 'package:dwallet/app/presantation/pages/security_page/security_page.dart';
import 'package:flutter/material.dart';
import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<SettingController> {
  SettingPage({Key? key}) : super(key: key){
    controller.getPassCode().then((response) {
      if(response.isEmpty){
        controller.enableSecurity.value = false;
      }else{
        controller.enableSecurity.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: controller.isDark.value? IColor().DARK_HOME_LIST_BG_COLOR:IColor().LIGHT_HOME_LIST_BG_COLOR,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            child: Column(
              children: [

                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: controller.isDark.value?Colors.white54:Colors.black54),
                ),
                SizedBox(height: 8.0,),
                Row(
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
                                fontSize: 18, color: controller.isDark.value?Themes.dark.primaryColor:Themes.light.primaryColor),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          color: controller.isDark.value?Colors.white:Colors.black
                        ),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                SizedBox(height: 16.0,),
                InkWell(
                  onTap: (){
                    controller.onSecurityTap();

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: controller.isDark.value? IColor().DARK_TOKEN_WIDGET_COLOR:IColor().LIGHT_TOKEN_WIDGET_COLOR,),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                          Row(
                            children: [
                              Image.asset(controller.isDark.value?"assets/images/icons/security_dark.png":"assets/images/icons/security_light.png",width: 18.0),
                              SizedBox(width: 16.0,),
                              Text("Security",style: TextStyle(color: controller.isDark.value?Colors.white:Colors.black),)
                            ],
                          ),
                        ),
                        Switch(
                            activeTrackColor: IColor().Dark_CHECK_COLOR,
                            activeColor: IColor().DARK_TEXT_COLOR,
                            inactiveTrackColor: IColor().DARK_INPUT_COLOR,
                            inactiveThumbColor: IColor().DARK_TEXT_COLOR,
                            value: controller.enableSecurity.value,
                            onChanged: (value) {
                              // controller.enableSecurity.value = value;
                              // if(value){
                              //   Get.bottomSheet(
                              //       isScrollControlled: true,
                              //       Container(
                              //           color: Colors.transparent,
                              //           margin: EdgeInsets.only(top: 80),
                              //           child: SecurityPage()));
                              // }
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0,),
                InkWell(
                  onTap: (){
                    controller.toggleTheme();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: controller.isDark.value? IColor().DARK_TOKEN_WIDGET_COLOR:IColor().LIGHT_TOKEN_WIDGET_COLOR,),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                          Row(
                            children: [
                              Image.asset("assets/images/icons/dark_mode.png",width: 18.0,color: controller.isDark.value?Colors.white:Colors.black),
                              SizedBox(width: 16.0,),
                              Text("Dark Mode",style: TextStyle(color: controller.isDark.value?Colors.white:Colors.black),)
                            ],
                          ),
                        ),
                        Switch(
                            activeTrackColor: IColor().Dark_CHECK_COLOR,
                            activeColor: IColor().DARK_TEXT_COLOR,
                            inactiveTrackColor: IColor().DARK_INPUT_COLOR,
                            inactiveThumbColor: IColor().DARK_TEXT_COLOR,
                            value: controller.isDark.value,
                            onChanged: (value) {
                              controller.isDark.value = value;
                            }),
                      ],
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () =>
                //       controller.toggleTheme(),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Row(
                //       children: [
                //         Icon(controller.isDark.value
                //             ? Icons.light_mode
                //             : Icons.dark_mode)
                //       ],
                //     ),
                //   ),
                // ),
                // const Divider(),
                // InkWell(
                //   onTap: () => controller.toggleLanguage(),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Row(
                //       children: [
                //         Text(controller.isEn.value ? 'English' : 'فارسی',
                //             style: Theme.of(context).textTheme.subtitle1)
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
    );
  }
}
