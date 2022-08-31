import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecretPhraseLength extends StatelessWidget {
  int? length;
  Color? fillColor;
  Color? lengthCOlor;

  SecretPhraseLength(
      {required this.length,
      required this.fillColor,
      required this.lengthCOlor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: Text(
        length.toString(),
        style: TextStyle(
            color: lengthCOlor!, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Get.isDarkMode?Colors.white:Colors.black),
        shape: BoxShape.circle,
        color: fillColor,
      ),
      alignment: Alignment.center,
    );
  }
}
