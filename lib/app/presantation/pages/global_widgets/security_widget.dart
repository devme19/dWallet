import 'package:dwallet/app/presantation/controllers/setting_controller.dart';
import 'package:dwallet/app/presantation/routes/app_routes.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SecurityWidget extends StatefulWidget {
  SecurityWidget({Key? key,this.addPassCode=true,this.isSplash=false}) : super(key: key);
  bool addPassCode;
  bool isSplash;

  @override
  State<SecurityWidget> createState() => _SecurityWidgetState();
}

class _SecurityWidgetState extends State<SecurityWidget> {
  bool code1= false,code2= false,code3= false,code4 = false;
  String passCode="";
  String confirmPassCode="";
  String title = "";
  SettingController controller = Get.find();

  @override
  void initState() {
    super.initState();
    if(widget.addPassCode){
      title = "Create local passCode";
    }
    else{
      title = "Enter passCode";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Get.isDarkMode? IColor().DARK_HOME_LIST_BG_COLOR:IColor().LIGHT_HOME_LIST_BG_COLOR,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        widget.isSplash?Container():Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Get.isDarkMode?Colors.white54:Colors.black54),
        ),
        SizedBox(height: 8.0,),
        widget.isSplash?SizedBox(height: 0,):Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 18,
                        color: Get.isDarkMode?Themes.dark.primaryColor:Themes.light.primaryColor
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                "Security",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // color: Get.isDarkMode?Colors.white:Colors.black
                ),
              ),
            ),
            Expanded(child: Container(
            ))
          ],
        ),
        SizedBox(height: 32.0,),
        Container(
          child: Column(children: [
            Image.asset(Get.isDarkMode?"assets/images/icons/security_dark.png":"assets/images/icons/security_light.png"),
            SizedBox(height: 16.0,),
            Text(title),
          ],),
        ),
        SizedBox(height: 32.0,),
        SizedBox(
          width: Get.width/2.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      code1=true;
                    });
                  },
                  child: passCodeWidget(code1)),
              InkWell(
                  onTap: () {
                    setState(() {
                      code2=true;
                    });
                  },
                  child: passCodeWidget(code2)),
              InkWell(
                  onTap: () {
                    setState(() {
                      code3=true;
                    });
                  },
                  child: passCodeWidget(code3)),
              InkWell(
                  onTap: () {
                    setState(() {
                      code4=true;
                    });
                  },
                  child: passCodeWidget(code4)),
            ],
          ),
        ),
        SizedBox(height: 32.0,),
        numKeys(),
      ],),
    );
  }

  Widget passCodeWidget(bool code){
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: code?Get.theme.primaryColor:Colors.grey,),
          color: code?Get.theme.primaryColor:Colors.transparent
      ),
    );
  }
  createPassCode(String code){
    if(passCode.length<4){
      if(passCode.isEmpty){
        code1 = true;
      }
      if(passCode.length == 1){
        code2 = true;
      }
      if(passCode.length == 2){
        code3 = true;
      }
      if(passCode.length == 3){
        code4 = true;
      }
      passCode+=code;
      setState(() {});
    }
    print(passCode);
  }
  Widget numKeys(){
    double space = 20.0;
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            key("1"),
            SizedBox(width: space,),
            key("2"),
            SizedBox(width: space,),
            key("3"),
          ],
        ),
        SizedBox(height: space,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            key("4"),
            SizedBox(width: space,),
            key("5"),
            SizedBox(width: space,),
            key("6"),
          ],
        ),
        SizedBox(height: space,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            key("7"),
            SizedBox(width: space,),
            key("8"),
            SizedBox(width: space,),
            key("9"),
          ],
        ),
        SizedBox(height: space,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: (){
                  if(passCode.length == 4){
                    passCode = passCode.substring(0,3);
                    code4 = false;
                  }else if(passCode.length == 3){
                    passCode = passCode.substring(0,2);
                    code3 = false;
                  }else if(passCode.length == 2){
                    passCode = passCode.substring(0,1);
                    code2 = false;
                  }else if(passCode.length == 1){
                    passCode = "";
                    code1 = false;
                  }
                  print(passCode);
                  setState(() {
                  });
                },
                child: iconKey("assets/images/icons/back_space.png")),
            SizedBox(width: space,),
            key("0"),
            SizedBox(width: space,),
            InkWell(
                onTap: (){
                  if(passCode.length==4){
                    if(widget.addPassCode){
                      if(confirmPassCode == "") {
                        confirmPassCode = passCode;
                        code1 = false;
                        code2 = false;
                        code3 = false;
                        code4 = false;
                        passCode = "";
                        title = "Confirm local passcode";
                        setState(() {});
                      }else if(confirmPassCode == passCode){
                        controller.setPassCode(confirmPassCode);
                        controller.enableSecurity.value = true;
                      }else{
                        Fluttertoast.showToast(msg:"PassCode and confirm not matched");
                      }
                    }else{
                      if(controller.passCode == passCode){
                        if(widget.isSplash){
                          Get.offAllNamed(AppRoutes.homePage,parameters: {'initial':'false'});
                        }
                        else{
                          controller.setPassCode("");
                          controller.enableSecurity.value = false;
                          Fluttertoast.showToast(msg:"PassCode Successfully removed");
                        }
                      }
                      else{
                        Fluttertoast.showToast(msg:"Incorrect passCode");
                      }
                    }
                  }else{
                    Fluttertoast.showToast(msg:"Please enter 4 digits passcode");
                  }
                },
                child: iconKey("assets/images/icons/arrow.png")),
          ],
        ),
      ],),
    );
  }
  Widget key(String num){
    return
      InkWell(
        onTap: (){
          createPassCode(num);
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Get.isDarkMode?Colors.black:Colors.white
          ),
          child: Center(child: Text(num,style: TextStyle(color: Get.theme.primaryColor,fontWeight: FontWeight.bold,fontSize: 26.0),)),
        ),
      );
  }
  Widget iconKey(String iconPath){
    return  Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Get.isDarkMode?Colors.black:Colors.white
      ),
      child: Center(child: Image.asset(iconPath,color: Get.theme.primaryColor,)),
    );
  }
}

