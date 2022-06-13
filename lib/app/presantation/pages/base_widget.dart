import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseWidget extends StatelessWidget {
  Widget? child;
  BaseWidget({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/images/Vector 2.svg",
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.center,
          child:
          child,
        )
      ],
    );
  }
}
