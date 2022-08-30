import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputWidget extends StatelessWidget {
  TextEditingController? controller;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  bool isNumberMode;
  InputWidget({Key? key, required this.hint,this.controller,this.onSubmit,this.onChange,this.isNumberMode=false}) : super(key: key);
  String? hint;
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
          border: Border.all(color: settingController.isDark.value?Color(0xff636366):Color(0xff636366)),
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent),
      child: TextFormField(
        keyboardType:isNumberMode? TextInputType.number:TextInputType.text,
        // ignore: curly_braces_in_flow_control_structures
        validator: (value){
          if(hint == "Recipient Address"){
            if(value!.isEmpty){
              return "enter recipient address";
            }
            else {
              return null;
            }
          }else if(hint == "Amount"){
            if(value!.isEmpty){
              return "enter amount";
            }
            else {
              return null;
            }
          }

        },
        onFieldSubmitted: (value) {
          if(onSubmit != null) {
            onSubmit!(value);
          }
        },
        controller:controller,
        onChanged: onChange,
        decoration: InputDecoration(
        filled: true,
        fillColor: settingController.isDark.value?Color(0xff2C2C2E):Colors.white,
        hintText: hint,
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide:BorderSide.none

        ),
        border:OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide:BorderSide.none
        )
          ),
    ));
  }
}

