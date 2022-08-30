import 'package:flutter/material.dart';
import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => Column(
            children: [
              InkWell(
                onTap: () =>
                    controller.toggleTheme(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(controller.isDark.value
                          ? Icons.light_mode
                          : Icons.dark_mode)
                    ],
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () => controller.toggleLanguage(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(controller.isEn.value ? 'English' : 'فارسی',
                          style: Theme.of(context).textTheme.subtitle1)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
