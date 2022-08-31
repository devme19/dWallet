import 'dart:ui';

import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:dwallet/app/presantation/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RulesBoxWidget extends StatefulWidget {
  RulesBoxWidget(
      {required this.rule,
      required this.agree,
      required this.result,
      Key? key})
      : super(key: key);
  String? rule;
  bool? agree;
  ValueChanged<bool>? result;

  @override
  State<RulesBoxWidget> createState() => _RulesBoxWidgetState();
}

class _RulesBoxWidgetState extends State<RulesBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        borderRadius: BorderRadius.circular(BUTTON_RADIUS),
        onTap: (){
          setState(() {
            widget.agree = !widget.agree!;
            widget.result!(widget.agree!);
          });
        },
        child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BUTTON_RADIUS),
            color: !widget.agree!
                ? Color(0xff636366).withOpacity(0.15)
                : Colors.green.withOpacity(0.15)),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0
        ),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: Text(
                  widget.rule!,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: widget.agree!
                          ? Colors.green
                          : Get.isDarkMode?Colors.white:Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                )),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.agree!?Colors.green:Get.isDarkMode?Colors.white:Colors.black
                )
              ),
              child: Icon(Icons.check,color: widget.agree!?Colors.green:Colors.transparent),
            ),
            // Expanded(
            //   flex: 1,
            //   child:
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Transform.scale(
            //         scale: 1.8,
            //         child: Checkbox(
            //             side: BorderSide.none,
            //             tristate: false,
            //             activeColor: !widget.agree!
            //                 ? widget.color!
            //                 : IColor().Dark_CHECK_COLOR.withOpacity(0.1),
            //             // checkColor: IColor().Dark_CHECK_COLOR,
            //             splashRadius: 10,
            //             value: widget.agree,
            //             onChanged: (value) {
            //               setState(() {
            //                 widget.agree = value;
            //                 widget.result!(value!);
            //               });
            //             }),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
    ),
      );
  }

}
