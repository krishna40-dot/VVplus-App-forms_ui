import 'dart:async';

mixin Validators{

  var phoneValidator = StreamTransformer<String,String>.fromHandlers(

      handleData: (phone,sink){
        bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone);
        if(phoneValid){
          sink.add(phone);
        }
        else{
          sink.addError("Mobile Number is not valid");
        }
      }
  );

  var otpValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (otp,sink){
        bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{5,10}$)').hasMatch(otp);
        if(phoneValid){
          sink.add(otp);
        }else{
          sink.addError("otp length should be greater than 4 and less than 11.");
        }
      }
  );
}