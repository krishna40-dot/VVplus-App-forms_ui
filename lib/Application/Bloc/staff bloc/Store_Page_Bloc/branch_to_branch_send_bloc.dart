// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/domain/value_objects/Validators/text_field_validators.dart';

class BranchToBranchSendBloc{
  // Declare streams
  final _requestQty = BehaviorSubject<String>();
  final _ratefield = BehaviorSubject<String>();
  final _dropDownField = BehaviorSubject<String>.seeded("Item list 1");
  final _textController = BehaviorSubject<String>();
  final _textController1 = BehaviorSubject<String>();

  // set Data
  Function(String) get changerequestQty => _requestQty.sink.add;
  Function(String) get changeratefield => _ratefield.sink.add;
  Function(String) get inDropField1 => _dropDownField.sink.add;
  Function(String) get inDropField2 => _dropDownField.sink.add;
  Function(String) get intextField => _textController.sink.add;
  Function(String) get intextField1 => _textController1.sink.add;


  Stream<String> get requestQty =>  _requestQty.stream.transform(textFieldValidator);
  Stream<double> get ratefield =>  _ratefield.stream.transform(validateRateField);
  Stream<String> get outDropField1  => _dropDownField.stream;
  Stream<String> get outDropField2  => _dropDownField.stream;
  Stream<String> get outtextField => _textController.stream.transform(textFieldValidator);
  Stream<String> get outtextField1 => _textController1.stream.transform(textFieldValidator);
  //Stream<bool> get MaterialValid => Observable.combineLatest2(requestQty,_ratefield,(requestQty,_ratefield)=>true);
  Stream<bool> get submitCheck =>
      Rx.combineLatest2(requestQty, ratefield, (p, o,) => true);


  List<String> names = [
    "Item list 1",
    "Item list 2",
    "Item list 3",
    "Item list4"
  ];

  dispose(){
    _requestQty.close();
    _ratefield.close();
    _dropDownField.close();
    _textController.close();
  }

  //Functiions
  submitProduct(){
    //print('Product Submitted Name: ${_requestQty.value} and Price: ${_ratefield.value}');
  }
}

class BranchToBranchSendProvider extends InheritedWidget{
  final BranchToBranchSendBloc bloc;

  BranchToBranchSendProvider({Key key, Widget child})
      :bloc = BranchToBranchSendBloc(),
        super(key : key, child : child);

  @override
  bool updateShouldNotify(_) => true;

  static BranchToBranchSendBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<BranchToBranchSendProvider>())
        .bloc;
  }

}