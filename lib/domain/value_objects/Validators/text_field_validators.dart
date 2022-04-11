import 'dart:async';

mixin TextValidators{

  var textFieldValidator = StreamTransformer<String, String>.fromHandlers(

      handleData: (textField, sink) {
        bool phoneValid = RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(textField);
        if (phoneValid) {
          sink.add(textField);
        }
        else {
          sink.addError("Enter valid detail");
        }
      }
  );
}

//Transformers
final validateRequestQty = StreamTransformer<String,double>.fromHandlers(
    handleData: (requestQty, sink){
      try{
        sink.add(double.parse(requestQty));
      }catch(error){
        sink.addError('Enter a valid Quantity');
      }
    }
);

final validateRateField = StreamTransformer<String,double>.fromHandlers(
    handleData: (ratefield, sink){
      try{
        sink.add(double.parse(ratefield));
      }catch(error){
        sink.addError('Enter a valid Rate');
      }
    }
);

final textFieldValidator = StreamTransformer<String, String>.fromHandlers(

    handleData: (textField, sink) {
      bool phoneValid = RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(textField);
      if (phoneValid) {
        sink.add(textField);
      }
      else {
        sink.addError("Field is not valid");
      }
    }
);