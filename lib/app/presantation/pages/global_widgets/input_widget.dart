import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatelessWidget {
  TextEditingController? controller;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  bool isNumberMode;
  InputWidget({Key? key, required this.hint,this.controller,this.onSubmit,this.onChange,this.isNumberMode=false}) : super(key: key);
  String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
          border: Border.all(color: IColor().DARK_TEXT_COLOR.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent),
      child: TextField(
        keyboardType:isNumberMode? TextInputType.number:TextInputType.text,
        // ignore: curly_braces_in_flow_control_structures
        onSubmitted: (value) {
          if(onSubmit != null) {
            onSubmit!(value);
          }
        },
        controller:controller,
        onChanged: onChange,
        decoration: InputDecoration(
            fillColor: Colors.transparent,
            hintText: hint,
            hintStyle:
                TextStyle(color: IColor().DARK_TEXT_COLOR.withOpacity(0.5))),
      ),
    );
  }
}
