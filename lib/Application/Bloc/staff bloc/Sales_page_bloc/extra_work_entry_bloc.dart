// ignore_for_file: avoid_renaming_method_parameters

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/domain/value_objects/Validators/text_field_validators.dart';

class StaffBloc{
  // Declare streams
  final _dropDownField1 = BehaviorSubject<String>.seeded("Item list 1");
  final _dropDownField2 = BehaviorSubject<String>.seeded("Item list 1");
  final _dropDownField3 = BehaviorSubject<String>.seeded("Item list 1");
  final _textController = BehaviorSubject<String>();
  final _textController1 = BehaviorSubject<String>();
  final _textController2 = BehaviorSubject<String>();

  // set Data
  //Function(String) get changerequestQty => _requestQty.sink.add;
  //Function(String) get changeratefield => _ratefield.sink.add;
  Function(String) get inDropField1 => _dropDownField1.sink.add;
  Function(String) get inDropField2 => _dropDownField2.sink.add;
  Function(String) get inDropField3 => _dropDownField3.sink.add;
  Function(String) get intextField1 => _textController.sink.add;
  Function(String) get intextField2 => _textController1.sink.add;
  Function(String) get intextField3 => _textController2.sink.add;


  //Stream<double> get requestQty =>  _requestQty.stream.transform(validateRequestQty);
  //Stream<double> get ratefield =>  _ratefield.stream.transform(validateRateField);
  Stream<String> get outDropField1  => _dropDownField1.stream;
  Stream<String> get outDropField2  => _dropDownField2.stream;
  Stream<String> get outDropField3  => _dropDownField3.stream;
  Stream<String> get outtextField1 => _textController.stream.transform(textFieldValidator);
  Stream<String> get outtextField2 => _textController1.stream.transform(textFieldValidator);
  Stream<String> get outtextField3 => _textController2.stream.transform(textFieldValidator);
  //Stream<bool> get MaterialValid => Observable.combineLatest2(requestQty,_ratefield,(requestQty,_ratefield)=>true);


  List<String> names = [
    "Item list 1",
    "Item list 2",
    "Item list 3",
    "Item list4"
  ];

  dispose(){
    _dropDownField1.close();
    _dropDownField2.close();
    _dropDownField3.close();
    _textController.close();
    _textController1.close();
    _textController2.close();
  }

  //Functiions
  submitProduct(){
    //print('Product Submitted Name: ${_requestQty.value} and Price: ${_ratefield.value}');
  }
}

class SalesExtraWorkEntryProvider extends InheritedWidget{
  final StaffBloc bloc;

  SalesExtraWorkEntryProvider({Key key, Widget child})
      :bloc = StaffBloc(),
        super(key : key, child : child);

  @override
  bool updateShouldNotify(_) => true;

  static StaffBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<SalesExtraWorkEntryProvider>())
        .bloc;
  }

}