// ignore_for_file: avoid_renaming_method_parameters

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/domain/value_objects/Validators/text_field_validators.dart';

class DailyManPowerBloc{
  // Declare streams
  final _partyNameDropDownField = BehaviorSubject<String>.seeded("Item list 1");
  final _phaseDropDownField = BehaviorSubject<String>.seeded("Item list 1");
  final _resourceTypeDropDownField = BehaviorSubject<String>.seeded("Item list 1");
  final _qtyTextController = BehaviorSubject<String>();
  final _remarksTextController = BehaviorSubject<String>();

  // set Data

  Function(String) get inDropField1 => _partyNameDropDownField.sink.add;
  Function(String) get inDropField2 => _phaseDropDownField.sink.add;
  Function(String) get inDropField3 => _resourceTypeDropDownField.sink.add;
  Function(String) get inTextField1 => _qtyTextController.sink.add;
  Function(String) get inTextField2 => _remarksTextController.sink.add;

  Stream<String> get outDropField1  => _partyNameDropDownField.stream;
  Stream<String> get outDropField2  => _phaseDropDownField.stream;
  Stream<String> get outDropField3  => _resourceTypeDropDownField.stream;
  Stream<String> get outTextField1 => _qtyTextController.stream.transform(textFieldValidator);
  Stream<String> get outTextField2 => _remarksTextController.stream.transform(textFieldValidator);


  List<String> names = [
    "Item list 1",
    "Item list 2",
    "Item list 3",
    "Item list4"
  ];

  dispose(){
    _partyNameDropDownField.close();
    _phaseDropDownField.close();
    _resourceTypeDropDownField.close();
    _qtyTextController.close();
    _remarksTextController.close();
  }

  //function
  submitProduct(){
    //print('Product Submitted Name: ${_textController.value}');
  }
}



class ContractorProvider extends InheritedWidget{
  final DailyManPowerBloc bloc;

  ContractorProvider({Key key, Widget child})
      :bloc = DailyManPowerBloc(),
        super(key : key, child : child);

  @override
  bool updateShouldNotify(_) => true;

  static DailyManPowerBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<ContractorProvider>()).bloc;
  }

}