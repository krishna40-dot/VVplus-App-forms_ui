// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/unit_cancellation_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:connectivity/connectivity.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class UnitCancellationBody extends StatefulWidget {
  const UnitCancellationBody({Key key}) : super(key: key);
  @override
  State<UnitCancellationBody> createState() => MyUnitCancellationBody();
}
class MyUnitCancellationBody extends State<UnitCancellationBody> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  TextEditingController baseAmount = TextEditingController();
  TextEditingController remarks = TextEditingController();
  DepartmentNameDropdownBloc departmentNameDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc1;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc2;
  final unitCancellationFormKey = GlobalKey<FormState>();

  DepartmentName selectDepartmentName;
  VoucherType selectVoucherType1;
  VoucherType selectVoucherType2;
  var subscription;
  var connectionStatus;

  void onDataChange1(DepartmentName state) {
    setState(() {
      selectDepartmentName = state;
    });
  }
  void onDataChange2(VoucherType state) {
    setState(() {
      selectVoucherType1 = state;
    });
  }
  void onDataChange3(VoucherType state) {
    setState(() {
      selectVoucherType2 = state;
    });
  }
  @override
  void initState() {
    dateinput.text = "";
    departmentNameDropdownBloc = DepartmentNameDropdownBloc();
    voucherTypeDropdownBloc1 = VoucherTypeDropdownBloc();
    voucherTypeDropdownBloc2 = VoucherTypeDropdownBloc();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => connectionStatus = result );
    });
    super.initState();
  }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  int valueChoose = 4;

  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }
  verifyDetail(){
    if(connectionStatus == ConnectivityResult.wifi || connectionStatus == ConnectivityResult.mobile){
      if(selectDepartmentName!=null && selectVoucherType1!=null && unitCancellationFormKey.currentState.validate()){
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
      await http.post(Uri.parse(ApiService.mockDataPostUnitCancellation),
          body: json.encode({
            "CancellationDate": dateinput.text,
            "BookingId": selectDepartmentName.strSubCode,
            "ChangeApplicable": selectVoucherType1.strSubCode,
            "DueDate": dueDate.text,
            "BaseAmmount": baseAmount.text,
            "Remarks": remarks.text

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
  @override
  Widget build(BuildContext context) {
    final bloc = UnitCancellationProvider.of(context);
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Form(
          key: unitCancellationFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: paddingForms2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      onPressed: () {dateinput.clear();
                      dueDate.clear();
                      baseAmount.clear();
                      remarks.clear();},
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ],
                ),
              ),
              formsHeadText("Cancellation Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
                child: TextFormField(
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if(val != dateinput.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: dateinput,
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
                        dateinput.text = formattedDate;
                      });
                    } else {
                    }
                  },
                ),
              ),
              formsHeadText("Booking Id"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52, width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<DepartmentName>>(
                      future: departmentNameDropdownBloc.departmentNameData,
                      builder: (context, snapshot) {
                        return StreamBuilder<DepartmentName>(
                            stream: departmentNameDropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<DepartmentName>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectDepartmentName!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectDepartmentName,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<DepartmentName>>((e) {
                                  return DropdownMenuItem<DepartmentName>(
                                    value: e,
                                    child: Text(e.strSubCode),
                                  );
                                })?.toList() ??[],
                              );
                            }
                        );
                      }
                  ),
                ),
              ),

              selectDepartmentName!=null ?
              InformationBoxContainer4(
                text1: selectDepartmentName.strName,
                text2: selectDepartmentName.strSubCode,
                text3: selectDepartmentName.strSubCode,
                text4: selectDepartmentName.strSubCode,
                text5: selectDepartmentName.strSubCode,
                text6: selectDepartmentName.strSubCode,
                text7: selectDepartmentName.strSubCode,
                text8: selectDepartmentName.strSubCode,
                text9: selectDepartmentName.strSubCode,
              ) : const SizedBox(),
              sizedbox1,
              formsHeadText("Change Applicable"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52, width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<VoucherType>>(
                      future: voucherTypeDropdownBloc1.voucherTypeDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<VoucherType>(
                            stream: voucherTypeDropdownBloc1.selectedState,
                            builder: (context, item) {
                              return SearchChoices<VoucherType>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                underline: "",
                                padding: selectVoucherType1!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType1,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<VoucherType>>((e) {
                                  return DropdownMenuItem<VoucherType>(
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
              sizedbox1,
              formsHeadText("Due Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
                child: TextFormField(
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if(val != dueDate.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: dueDate,
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
                        dueDate.text = formattedDate;
                      });
                    } else {
                    }
                  },
                ),
              ),
              formsHeadText("Base Amount (deduction amount)"),
              Container(
                height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  width: 320,
                  child: StreamBuilder<String>(
                    stream: bloc.outtextField1,
                    builder: (context, snapshot) => TextFormField(
                      validator: (val) {
                        if(val.isEmpty) {
                          return 'Enter Detail';
                        }
                        if(val != baseAmount.text) {
                          return RegExp(r'^[a-zA-Z0-9._ ]+$').hasMatch(val) ? null
                              : "Enter valid detail";
                        }
                        return null;
                      },
                      controller: baseAmount,
                      onChanged: bloc.intextField1,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColor8,
                          enabledBorder: textFieldBorder(),
                          focusedBorder: textFieldBorder(),
                          errorText: snapshot.error,
                        isDense: true,
                        errorBorder: textFieldBorder(),

                      ),
                      keyboardType: TextInputType.text,
                      style: simpleTextStyle7(),
                    ),
                  ),
                ),
              ),
              sizedbox1,
              formsHeadText("Tax:"),
              sizedbox1,
              formsHeadText("Remarks"),
              Container(
                height: 70,
                padding: padding1,
                decoration: decoration1(),
                child: SizedBox(
                  width: 320,
                  child: StreamBuilder<String>(
                    stream: bloc.outtextField2,
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
                      onChanged: bloc.intextField2,
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
              sizedbox1,
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Submit",(){verifyDetail();},roundedButtonHomeColor1)),
            ],
          ),
        ),
      ),
    );
  }
}