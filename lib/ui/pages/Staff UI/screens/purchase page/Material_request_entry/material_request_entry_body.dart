// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_current_status_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Purchase_Page_Bloc/material_request_entry_page_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/add_item_container.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'dart:io';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class MaterialEntryBody extends StatefulWidget {

  const MaterialEntryBody({Key key}) : super(key: key);
  @override
  State<MaterialEntryBody> createState() => MyMaterialEntryBody();
}

class MyMaterialEntryBody extends State<MaterialEntryBody> {

  bool isActive = false;
  bool pressed = false;
  bool showAmount = false;
  var subscription;
  var connectionStatus;
  double  value1 = 0,value2 = 46.599;
  double _amount;
  String StringAmount;


  void clearData(){
    reqQty.clear();
  }

  TextEditingController intendDateInput = TextEditingController();
  TextEditingController reqDateInput = TextEditingController();
  TextEditingController indentType = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController reqQty = TextEditingController(text:'0');
  TextEditingController rate = TextEditingController();
  TextEditingController costCenter = TextEditingController();
  TextEditingController remarks = TextEditingController();

  final materialRequestEntryFormKey = GlobalKey<FormState>();

  String dropdownValue = 'Choose an option';
  IndentorNameDropdownBloc dropdownBlocIndentorName;
  ItemCurrentStatusDropdownBloc dropdownBlocItemCurrentStatus;
  ItemCostCenterDropdownBloc dropdownBlocItemCostCenter;


  String Item = "";
  String Qty = "";
  String Rate="";

  void getDropDownItem(){
    setState(() {
      Item = dropdownValue ;
    });
  }
    _calculation() {
    setState(() {
      //value1 = double.parse(reqQty.text);
      _amount = (double.parse(reqQty.text)*double.parse(selectItemCurrentStatus.dblQty));
      StringAmount= _amount.toStringAsFixed(3);
    },);
    print(_amount);
  }

  @override
  void initState() {
    _amount = 0;
    super.initState();
    reqQty = TextEditingController();
    reqQty.addListener(() {
      if (isActive = reqQty.text.isNotEmpty) {
        isActive = true;
      }
      setState(() => isActive = isActive);
    });
    intendDateInput.text = "";
    reqDateInput.text="";
    dropdownBlocIndentorName = IndentorNameDropdownBloc();
    dropdownBlocItemCurrentStatus = ItemCurrentStatusDropdownBloc();
    dropdownBlocItemCostCenter = ItemCostCenterDropdownBloc();
    _amount = 0;
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => connectionStatus = result );
    });
    super.initState();
  }
  verifyDetail(){
    if(connectionStatus == ConnectivityResult.wifi || connectionStatus == ConnectivityResult.mobile){
      if(selectIndentName!=null && selectItemCurrentStatus!=null && selectItemCostCenter!=null && materialRequestEntryFormKey.currentState.validate()){
        sendData();
      }
      else{
        Scaffold.of(context).showSnackBar(snackBar(incorrectDetailText));
      }
    }
    else{
      Scaffold.of(context).showSnackBar(snackBar(internetFailedConnectionText));
    }
  }

  Future<dynamic> sendData() async{
    try {
      await http.post(Uri.parse(ApiService.mockDataPostMaterialRequestEntryURL),
          body: json.encode({
            "IndentSubCode":selectIndentName.strSubCode,
            "IntendDate":intendDateInput.text,
            "ItemName":selectItemCurrentStatus.strItemName,
            "ReqQty":reqQty.text,
            "ItemUnit":selectItemCurrentStatus.strUnit,
            "Rate":selectItemCurrentStatus.dblQty,
            "ItemSubCode":selectItemCostCenter.strSubCode,
            "ReqDate":reqDateInput.text,
            "Remarks":remarks.text
          }));
      Scaffold.of(context).showSnackBar(snackBar(sendDataText));
    } on SocketException {
      Scaffold.of(context).showSnackBar(snackBar(socketExceptionText));
    } on HttpException {
      Scaffold.of(context).showSnackBar(snackBar(httpExceptionText));
    } on FormatException {
      Scaffold.of(context).showSnackBar(snackBar(formatExceptionText));
    }
  }


  IndentorName selectIndentName;
  ItemCurrentStatus selectItemCurrentStatus;
  ItemCostCenter selectItemCostCenter;
  void onDataChange1(IndentorName state) {
    setState(() {
      selectIndentName = state;
    });
  }
  void onDataChange2(ItemCurrentStatus state) {
    setState(() {
      selectItemCurrentStatus= state;
    });
  }
  void onDataChange3(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter = state;
    });
  }

  int valueChoose = 4;

  onClear(){
    reqDateInput.clear();
    intendDateInput.clear();
    remarks.clear();
  }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void onDataChange4(ItemCurrentStatus state) {
    setState(() {
      selectItemCurrentStatus.strCostCenterName = state as String;
    });
  }
  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MaterialRequestEntryProvider.of(context);
    //_calculation();
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Form(
          key: materialRequestEntryFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: paddingForms,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      onPressed: () {onClear();},
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ],
                ),
              ),

              formsHeadText("Indent Type"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52, width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<IndentorName>>(
                      future: dropdownBlocIndentorName.indentorNameDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<IndentorName>(
                            stream: dropdownBlocIndentorName.selectedState,
                            builder: (context, item) {
                              return SearchChoices<IndentorName>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectIndentName!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectIndentName,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
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
              ),

              const Padding(padding: EdgeInsets.all(10)),

              formsHeadText("Indent Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
                child: TextFormField(
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if(val != intendDateInput.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: intendDateInput,
                  decoration: dateFieldDecoration(),
                  readOnly: true,
                  onTap: () async {
                    DateTime pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101)
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        intendDateInput.text = formattedDate;
                      });
                    }
                  },
                ),
              ),

              //============================================================ FormsContainer
              Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                        Padding(
                          padding: padding1,
                          child: Container(
                            height: 52, width: 343,
                            decoration: decorationForms(),
                            child: FutureBuilder<List<ItemCurrentStatus>>(
                                future: dropdownBlocItemCurrentStatus.itemCurrentStatusDropdowndata,
                                builder: (context, snapshot) {
                                  return StreamBuilder<ItemCurrentStatus>(
                                      stream: dropdownBlocItemCurrentStatus.selectedState,
                                      builder: (context, item) {
                                        return SearchChoices<ItemCurrentStatus>.single(
                                          icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                          padding: selectItemCurrentStatus!=null ? 2 : 11,
                                          isExpanded: true,
                                          hint: "Search here",
                                          value: selectItemCurrentStatus,
                                          displayClearIcon: false,
                                          onChanged: onDataChange2,
                                          items: snapshot?.data
                                              ?.map<DropdownMenuItem<ItemCurrentStatus>>((e) {
                                            return DropdownMenuItem<ItemCurrentStatus>(
                                              value: e,
                                              child: Text(e.strItemName),
                                            );
                                          })?.toList() ??[],
                                        );
                                      }
                                  );
                                }
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        formsHeadText("Request Qty. "),
                        Row(
                          children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 35),

                              child: Container(
                                height: 50,
                                padding: padding1,
                                decoration: decoration1(),


                                child: SizedBox(
                                  width: 130,

                                  child: StreamBuilder<String>(
                                      stream: bloc.requestQty,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          onEditingComplete: (){
                                            _calculation();
                                          },
                                          // initialValue: "no",
                                          controller: reqQty,
                                          decoration: InputDecoration(
                                            errorText: snapshot.error,
                                          ),
                                          onChanged: bloc.changerequestQty,
                                          keyboardType: TextInputType.number,

                                          //onSaved: selectItemCurrentStatus.strItemName,

                                          style: simpleTextStyle7(),
                                        );
                                      }
                                  ),
                                ),
                              ),
                            ),
                            selectItemCurrentStatus!=null ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  height: 50, padding: padding1, decoration: decoration1(),
                                  child: Center(
                                      child: Text(selectItemCurrentStatus.strUnit))),
                            ):
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  height: 50, padding: padding1, decoration: decoration1(),
                                  child: const Center(
                                      child: Text("No"))),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        Row(
                          children: [
                            formsHeadText("Rate"),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                            GestureDetector(
                              onTap: (){},
                              child: formsHeadText("Amount: "),  ),

                            //Text(_amount.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            selectItemCurrentStatus!=null ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: SizedBox(
                                width: 160,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                      height: 50, padding: padding1, decoration: decoration1(),
                                      child: Center(
                                          child: Text(selectItemCurrentStatus.dblQty))),
                                ),
                              ),
                            ):
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: SizedBox(
                                width: 160,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                      height: 50, padding: padding1, decoration: decoration1(),
                                      child: const Center(
                                          child: Text("No"))),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child:Text("$StringAmount",
                                  style: containerTextStyle1(),),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                            RaisedButton(
                              onPressed: () {reqQty.clear();},
                              elevation: 0.0,
                              color: storeContainerColor,
                              child: raisedButtonText("Clear This Item"),

                            ),
                                   RoundedButtonInput(
                                    text: "Add Item to List",
                                    press: (
                                        selectItemCurrentStatus !=null)&&(isActive)
                                        ? () {
                                      _calculation();
                                      setState(() {
                                        pressed = true;
                                      });
                                    } : null,
                                    fontsize1: 12,
                                    size1: 0.5,
                                    horizontal1: 30,
                                    vertical1: 10,
                                    color1: Colors.orange,
                                    textColor1: textColor1,
                                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              pressed? AddItemContainer(
                itemNameText: selectItemCurrentStatus.strItemName,
                orderQtyText: reqQty.text,
                rateText: selectItemCurrentStatus.dblQty,
                amountText: StringAmount.toString(),
              ) : const SizedBox(),
              //============================================================ popup container

//=============================================================================
              const Padding(padding: EdgeInsets.all(10)),

              formsHeadText("Choose Phase (Cost Center)"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52, width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: dropdownBlocItemCostCenter.itemCostCenterData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: dropdownBlocItemCostCenter.selectedState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectItemCostCenter!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<ItemCostCenter>>((e) {
                                  return DropdownMenuItem<ItemCostCenter>(
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
              ),
              const SizedBox(height: 15),
              formsHeadText("Req. Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
                child: TextFormField(
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if(val != reqDateInput.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: reqDateInput,
                  decoration: dateFieldDecoration(),
                  readOnly: true,
                  onTap: () async {
                    DateTime pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101)
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        reqDateInput.text = formattedDate;
                      });
                    } else {
                    }
                  },
                ),
              ),
              formsHeadText("Remarks"),
              Container(
                height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  width: 320,
                  child: StreamBuilder<String>(
                    stream: bloc.outtextField,
                    builder: (context, snapshot) => TextFormField(
                      validator: (val) {
                        if(val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if(val != remarks.text) {
                          return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val) ? null
                              : "Enter valid detail";
                        }
                        return null;
                      },
                      controller: remarks,
                      onChanged: bloc.intextField,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColor8,
                          enabledBorder: textFieldBorder(),
                          focusedBorder: textFieldBorder(),
                          isDense: true,
                          errorBorder: textFieldBorder(),
                          errorText: snapshot.error
                      ),
                      keyboardType: TextInputType.text,
                      style: simpleTextStyle7(),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                  child: roundedButtonHome(
                      "Submit",
                          (){verifyDetail();})
              ),
            ],
          ),
        ),
      ),
    );

  }
}