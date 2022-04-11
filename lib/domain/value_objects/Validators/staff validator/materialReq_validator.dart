// ignore_for_file: file_names

import 'dart:async';

mixin validator{
  var validateRequestQty = StreamTransformer<String, double>.fromHandlers(
      handleData: (requestQty, sink) {
        try {
          sink.add(double.parse(requestQty));
        } catch (error) {
          sink.addError('Enter a valid Quantity');
        }
      }
  );

  final validateRateField = StreamTransformer<String, double>.fromHandlers(
      handleData: (ratefield, sink) {
        try {
          sink.add(double.parse(ratefield));
        } catch (error) {
          sink.addError('Enter a valid Rate');
        }
      }
  );


}