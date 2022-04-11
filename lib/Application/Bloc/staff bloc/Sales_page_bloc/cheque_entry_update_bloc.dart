// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/domain/value_objects/Validators/text_field_validators.dart';

class ChequeEntryUpdateBloc{
  // Declare streams

  final _textController1 = BehaviorSubject<String>();
  final _textController2 = BehaviorSubject<String>();
  final _textController3 = BehaviorSubject<String>();

  // set Data
  Function(String) get intextField1 => _textController1.sink.add;
  Function(String) get intextField2 => _textController2.sink.add;
  Function(String) get intextField3 => _textController2.sink.add;

  Stream<String> get outtextField1 => _textController1.stream.transform(textFieldValidator);
  Stream<String> get outtextField2 => _textController2.stream.transform(textFieldValidator);
  Stream<String> get outtextField3 => _textController2.stream.transform(textFieldValidator);
  //Stream<bool> get MaterialValid => Observable.combineLatest2(requestQty,_ratefield,(requestQty,_ratefield)=>true);
 // Stream<bool> get submitCheck =>
    //  Rx.combineLatest2(requestQty, ratefield, (p, o,) => true);


  List<String> names = [
    "Item list 1",
    "Item list 2",
    "Item list 3",
    "Item list4"
  ];

  dispose(){
    _textController1.close();
    _textController2.close();
    _textController3.close();
  }

  //Functiions
  submitProduct(){
    //print('Product Submitted Name: ${_requestQty.value} and Price: ${_ratefield.value}');
  }
}

class ChequeEntryUpdateProvider extends InheritedWidget{
  final ChequeEntryUpdateBloc bloc;

  ChequeEntryUpdateProvider({Key key, Widget child})
      :bloc = ChequeEntryUpdateBloc(),
        super(key : key, child : child);

  @override
  bool updateShouldNotify(_) => true;

  static ChequeEntryUpdateBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<ChequeEntryUpdateProvider>())
        .bloc;
  }

}