import 'package:get/get.dart';

class Messages extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'enter phone number': 'enter phone number',
      'Clean Architecture': 'Clean Architecture',
      'Invalid Phone Number':'Invalid Phone Number',
      'enter verification code':'enter verification code',
      'Login':'Login',
      'Verify':'Verify'
    },
    'fa_IR': {
      'enter phone number': 'شماره همراه را وارد کنید',
      'Clean Architecture': 'معماری تمیز',
      'Invalid Phone Number':'شماره اشتباه است',
      'enter verification code':'کد اعتبارسنجی را وارد کنید',
      'Verify':'تایید',
      'Login':'ورود',
    }
  };
}