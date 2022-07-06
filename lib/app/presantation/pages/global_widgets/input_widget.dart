import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  TextEditingController? controller;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  InputWidget({Key? key, required this.hint,this.controller,this.onSubmit,this.onChange}) : super(key: key);
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
        onSubmitted: (value)=>onSubmit!(value),
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
