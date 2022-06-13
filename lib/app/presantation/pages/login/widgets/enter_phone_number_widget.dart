import 'package:flutter/material.dart';
import 'package:get/get.dart';
class EnterPhoneNumberWidget extends StatelessWidget {
  TextEditingController phoneNumberController = TextEditingController();
  ValueChanged<String> onSubmit;
  EnterPhoneNumberWidget({Key? key,required this.onSubmit}) : super(key: key){
    phoneNumberController.text = "";
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return
      Form(
        key: _formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TextFormField(
            validator: (value){
              if(value == null || value.isEmpty) {
                return "Invalid Phone Number".tr;
              }else {
                return null;
              }
            },
            controller: phoneNumberController,
            decoration: InputDecoration(
                hintText: "enter phone number".tr
            ),
          ),
          const SizedBox(height: 30.0,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: (){
              if(_formKey.currentState!.validate()) {
                onSubmit(phoneNumberController.text);
              }
            }, child: Text("Login".tr)),
          )
          // InkWell(
          //   onTap: () {
          //     onSubmit(phoneNumberController.text);
          //     // controller.login(phoneNumberController.text);
          //   },
          //   child: Container(
          //     height: 60,
          //     color: Colors.deepPurple,
          //     alignment: Alignment.center,
          //     child: const Text("Login",style: TextStyle(color: Colors.white)),
          //   ),
          // )
        ],
    ),
      );
  }
}
