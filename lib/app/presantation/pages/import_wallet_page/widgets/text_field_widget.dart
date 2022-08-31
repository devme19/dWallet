import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class TextFieldWidget extends StatelessWidget {
  int? index;
  TextEditingController? controller;
  TextFieldWidget({Key? key,this.index,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.all(3.0),
      padding: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(11.0)),
      child: Row(
        children: [
          Text(
            '$index - ',
            style: TextStyle(
              color: Colors.grey,
            ),
            textAlign: TextAlign.right,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: Colors.white,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              maxLines: 1,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
