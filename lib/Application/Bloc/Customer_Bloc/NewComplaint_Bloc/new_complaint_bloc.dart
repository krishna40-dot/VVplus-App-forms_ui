// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/domain/value_objects/Validators/text_field_validators.dart';

class NewComplaintPageBloc extends Object with TextValidators implements BaseBloc {
  final _textFieldController1 = BehaviorSubject<String>();
  final _textFieldController2 = BehaviorSubject<String>();
  final _textFieldController3 = BehaviorSubject<String>();
  final _textFieldController4 = BehaviorSubject<String>();
  final _dropDownField1 = BehaviorSubject<String>.seeded("");

  Function(String) get inTextField1 => _textFieldController1.sink.add;
  Function(String) get inTextField2 => _textFieldController2.sink.add;
  Function(String) get inTextField3 => _textFieldController3.sink.add;
  Function(String) get inTextField4 => _textFieldController4.sink.add;
  Function(String) get inDropField1 => _dropDownField1.sink.add;

  Stream<String> get outTextField1 => _textFieldController1.stream.transform(textFieldValidator);
  Stream<String> get outTextField2 => _textFieldController2.stream.transform(textFieldValidator);
  Stream<String> get outTextField3 => _textFieldController3.stream.transform(textFieldValidator);
  Stream<String> get outTextField4 => _textFieldController4.stream.transform(textFieldValidator);
  Stream<String> get outDropField1  => _dropDownField1.stream;

  List<String> names = [
    "Item list 1",
    "Item list 2",
    "Item list 3",
    "Item list4"
  ];

  submit() {
  }

  @override
  void dispose() {
    _textFieldController1?.close();
    _textFieldController2?.close();
    _textFieldController3?.close();
    _textFieldController4?.close();
    _dropDownField1.close();
  }
}

abstract class BaseBloc {
  void dispose();
}

class NewComplaintPageProvider extends InheritedWidget{
  final NewComplaintPageBloc bloc;

  NewComplaintPageProvider({Key key, Widget child})
      :bloc = NewComplaintPageBloc(),
        super(key : key, child : child);

  @override
  bool updateShouldNotify(_) => true;

  static NewComplaintPageBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<NewComplaintPageProvider>())
        .bloc;
  }

}