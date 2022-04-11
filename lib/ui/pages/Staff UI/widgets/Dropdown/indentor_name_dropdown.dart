import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class IndentorNameDropdown extends StatefulWidget {
  const IndentorNameDropdown({Key key}) : super(key: key);

  @override
  _IndentorNameDropdownState createState() => _IndentorNameDropdownState();
}

class _IndentorNameDropdownState extends State<IndentorNameDropdown> {
  IndentorNameDropdownBloc _dropdownBloc;

  @override
  void initState() {
    _dropdownBloc = IndentorNameDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding1,
      child: Container(
        height: 50, width: 343,
        decoration: decorationForms(),
        child: FutureBuilder<List<IndentorName>>(
            future: _dropdownBloc.indentorNameDropdownData,
            builder: (context, snapshot) {
              return StreamBuilder<IndentorName>(
                  stream: _dropdownBloc.selectedState,
                  builder: (context, item) {
                    return SearchChoices<IndentorName>.single(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      underline: "",
                      padding: 1,
                      isExpanded: true,
                      hint: "Search here",
                      value: item.data,
                      displayClearIcon: false,
                      onChanged: _dropdownBloc.selectedStateEvent,
                      items: snapshot?.data
                          ?.map<DropdownMenuItem<IndentorName>>((e) {
                        return DropdownMenuItem<IndentorName>(
                          value: e,
                          child: Text(e.strName),
                        );
                      })?.toList() ??[],
                    );
                  }
              );
            }
        ),
      ),
    );
  }

}

class IndentorNameDropdownFirestore extends StatefulWidget {
  const IndentorNameDropdownFirestore({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IndentorNameDropdownFirestore();
}


class _IndentorNameDropdownFirestore extends State<IndentorNameDropdownFirestore> {
  IndentorNameDropdownBloc _dropdownBloc;

  @override
  void initState() {
    _dropdownBloc = IndentorNameDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  // ignore: prefer_typing_uninitialized_variables
  var indentorName;
  var setDefaultMake = true, setDefaultMakeModel = true;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: padding1,
      child: Container(
        height: 50, width: 343,
        decoration: decorationForms(),
        child:StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('IndentorName')
              .orderBy('StrName')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            // Safety check to ensure that snapshot contains data
            // without this safety check, StreamBuilder dirty state warnings will be thrown
            if (!snapshot.hasData) return Container();
            // Set this value for default,
            // setDefault will change if an item was selected
            // First item from the List will be displayed
            return SearchChoices.single(
              icon: const Icon(Icons.keyboard_arrow_down_sharp),
              underline: "",
              padding: 1,
              isExpanded: true,
              hint: "Search here",
              displayClearIcon: false,
              value: indentorName,
              items: snapshot.data.docs.map((value) {
                if (setDefaultMake) {
                  indentorName = snapshot.data.docs[0].get('StrName');
                  debugPrint('setDefault make: $indentorName');
                }
                return DropdownMenuItem(
                  value: value.get('StrName'),
                  child: Text('${value.get('StrName')}'),
                );
              }).toList(),
              onChanged: (value) {
                debugPrint('selected onchange: $value');
                setState(
                      () {
                    debugPrint('make selected: $value');
                    // Selected value will be stored
                    indentorName = value;
                    // Default dropdown value won't be displayed anymore
                    setDefaultMake = false;
                    // Set makeModel to true to display first car from list
                    setDefaultMakeModel = true;
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

