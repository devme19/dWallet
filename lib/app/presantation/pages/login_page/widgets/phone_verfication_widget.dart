import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PhoneVerificationWidget extends StatelessWidget {
  ValueChanged<String> onVerificationSubmit;
  PhoneVerificationWidget({Key? key,required this.onVerificationSubmit}) : super(key: key);
  TextEditingController verificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      TextField(
        controller: verificationController,
        decoration: InputDecoration(
          hintText: "enter verification code".tr
        ),
      ),
        const SizedBox(height: 30.0,),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(

              onPressed: (){
            onVerificationSubmit(verificationController.text);
          }, child: Text("Verify".tr)),
        ),
    ],);
  }
}
