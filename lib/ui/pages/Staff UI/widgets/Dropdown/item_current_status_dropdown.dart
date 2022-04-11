// ignore_for_file: prefer_typing_uninitialized_variables, missing_return, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_current_status_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/staff_provider.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class ItemCurrentStatusDropdown extends StatefulWidget {
  const ItemCurrentStatusDropdown({Key key}) : super(key: key);

  @override
  _ItemCurrentStatusDropdownState createState() => _ItemCurrentStatusDropdownState();
}

class _ItemCurrentStatusDropdownState extends State<ItemCurrentStatusDropdown> {
  ItemCurrentStatusDropdownBloc _dropdownBloc;
  String selectedValue;

  @override
  void initState() {
    _dropdownBloc = ItemCurrentStatusDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  var itemName;
  var setDefaultMake = true, setDefaultMakeModel = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding1,
      child: Container(
        height: 50, width: 343,
        decoration: decorationForms(),
        child:StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('ItemName')
              .orderBy('Item')
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
              value: itemName,
              items: snapshot.data.docs.map((value) {
                if (setDefaultMake) {
                  itemName = snapshot.data.docs[0].get('Item');
                  debugPrint('setDefault make: $itemName');
                }
                return DropdownMenuItem(
                  value: value.get('Item'),
                  child: Text('${value.get('Item')}'),
                );
              }).toList(),
              onChanged: (value) {
                debugPrint('selected onchange: $value');
                setState(
                      () {
                    debugPrint('make selected: $value');
                    // Selected value will be stored
                    itemName = value;
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


class FormsContainerSearchDropDown extends StatefulWidget {
  const FormsContainerSearchDropDown({Key key}) : super(key: key);

  @override
  State<FormsContainerSearchDropDown> createState() => MyFormsContainerSearchDropDown();
}

class MyFormsContainerSearchDropDown extends State<FormsContainerSearchDropDown> {

  var itemName;
  var setDefaultMake = true, setDefaultMakeModel = true;
  //=======================================================
  ItemCurrentStatusDropdownBloc _dropdownBloc;
  String selectedValue;

  @override
  void initState() {
    _dropdownBloc = ItemCurrentStatusDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  //=======================================================

  List categoryItemList = [];
  TextEditingController reqQty = TextEditingController();
  TextEditingController rate = TextEditingController();

  //final GlobalKey<FormState> _formKey = GlobalKey();
  int valueChoose = 4;

  Widget _buildList(QuerySnapshot snapshot) {

    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
        }
    );
  }


          @override
  Widget build(BuildContext context) {
    final bloc = MaterialProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 378,
        width: SizeConfig.getWidth(context),
        decoration: BoxDecoration(
          color: storeContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Padding(padding: EdgeInsets.all(10)),
            formsHeadText("Item "),

           //===================================================================
        Padding(
          padding: padding1,
          child: Container(
            height: 50, width: 343,
            decoration: decorationForms(),
            child:StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('ItemName')
                  .orderBy('Item')
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
                  value: itemName,
                  items: snapshot.data.docs.map((value) {
                    if (setDefaultMake) {
                      itemName = snapshot.data.docs[0].get('Item');
                      debugPrint('setDefault make: $itemName');
                    }
                    return DropdownMenuItem(
                      value: value.get('Item'),
                      child: Text('${value.get('Item')}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    debugPrint('selected onchange: $value');
                    setState(
                          () {
                        debugPrint('make selected: $value');
                        // Selected value will be stored
                        itemName = value;
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
          ),
           //===================================================================

            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
              children:[
            formsHeadText("Request Qty. "),
                const SizedBox(width: 20),
                formsHeadText("Unit"),
            ],
            ),
            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                 //child:ItemName != null?
                      child: SizedBox(
                      width: 50,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection("ItemName").snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData) return const LinearProgressIndicator();
                            return Expanded(
                                child: _buildList(snapshot.data)
                            );

                          }
                      )
                      /*
                       FutureBuilder(
                        future: _dropdownBloc.itemCurrentStatusDropdowndata,
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                              itemBuilder: (context,index){
                                var list = snapshot.data[index];
                                return Text('dblQty');
                              }
                            );
                          }
                          return Text("No data Found");
                        }
                      ),*/
                    ),/*:SizedBox(
                   child: Text("data failure"),
                 ),*/
                  //:Text("No data"),
                ),
                const SizedBox(width: 20 ),
                _dropdownBloc.selectedStateEvent != null? Container(
                  height: 50,
                  padding: padding1,
                  decoration: decoration1(),
                  child: SizedBox(
                    width: 40,
                    child: FutureBuilder(
                        future: _dropdownBloc.itemCurrentStatusDropdowndata,
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                itemBuilder: (context,index){
                                  var list = snapshot.data[index];
                                  return ListTile(title:Text(list['strUnit']),);
                                }
                            );
                          }
                          return const Text("No data Found");
                        }
                    ),
                  ),
                ):const Text("No data"),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
              children: [
                formsHeadText("Rate"),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                formsHeadText("Amount:"),
              ],
            ),
            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),

                  child: Container(
                    height: 50,
                    padding: padding1,
                    decoration: decoration1(),

                    child: SizedBox(
                      width: 100,

                      child: StreamBuilder<double>(
                          stream: bloc.ratefield,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: rate,
                              decoration: InputDecoration(
                                errorText: snapshot.error,
                              ),
                              onChanged: bloc.changeratefield,
                              keyboardType: TextInputType.number,
                              style: simpleTextStyle7(),
                            );
                          }
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

            Row(
              children: [
                const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                RaisedButton(
                  onPressed: () {
                    reqQty.clear();
                    rate.clear();
                  },
                  elevation: 0.0,
                  color: storeContainerColor,
                  child: raisedButtonText("Clear This Item"),

                ),


                StreamBuilder<bool>(
                    stream: bloc.submitCheck,
                    builder: (context, snapshot) {
                      return RoundedButtonInput(
                        text: "Add Item to List",
                        press: !snapshot.hasData ? null: (){

                        } ,
                        fontsize1: 12,
                        size1: 0.5,
                        horizontal1: 30,
                        vertical1: 10,
                        color1: Colors.orange,
                        textColor1: textColor1,
                      );
                    }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}


BoxDecoration decorationFormsCont() {
  return BoxDecoration(
    color: primaryColor3,
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: primaryColor9, width: 1),

  );
}

