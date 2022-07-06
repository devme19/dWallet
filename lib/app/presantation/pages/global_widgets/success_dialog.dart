import 'package:flutter/material.dart';


class SuccessDialog extends StatelessWidget {
  String? dialogAlert;
  ValueChanged<bool>? onDone;
  SuccessDialog({required this.dialogAlert,this.onDone, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: 400,
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color(0xff2C2C2E),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Image.asset("assets/images/done.png")),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
                  child: Text(
                    dialogAlert!,
                    style: const TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.normal,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            onDone!(true);
                          },
                          child: const Text(
                            "Done",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w700,
                                fontSize: 22),
                          ))),
                ],
              )
            ],
          ),
    ),
        ),
      );
  }
}
