// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/godown_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_current_status_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/received_by_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Store_Page_Bloc/stock_receive_entry_bloc.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'package:vvplus_app/infrastructure/Models/godown_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'package:vvplus_app/infrastructure/Models/received_by_model.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/add_item_container.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:http/http.dart'as http;
import 'package:connectivity/connectivity.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'dart:io';


class StockReceiveEntryBody extends StatefulWidget{
  const StockReceiveEntryBody({Key key}) : super(key: key);
  @override
  State<StockReceiveEntryBody> createState() => MyStockReceiveEntryBody();
}
class MyStockReceiveEntryBody extends State<StockReceiveEntryBody> {
  bool isActive = false;
  TextEditingController reqQty = TextEditingController();
  final extraWorkEntryFormKey1 = GlobalKey<FormState>();
  bool pressed = false;

  VoucherTypeDropdownBloc voucherTypeDropdownBloc1;
  ReceivedByDropdownBloc receivedByDropdownBloc;
  VoucherTypeDropdownBloc voucherTypeDropdownBloc3;
  GodownDropdownBloc godownDropdownBloc;
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc;
  ItemCurrentStatusDropdownBloc dropdownBlocItemCurrentStatus;

  VoucherType selectVoucherType1;
  ReceivedBy selectReceivedBy;
  Godown selectGodown;
  VoucherType selectVoucherType3;
  ItemCostCenter selectItemCostCenter;
  ItemCurrentStatus selectItemCurrentStatus;
  var subscription;
  var connectionStatus;

  double _amount;
  String StringAmount;



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
      if(isActive = reqQty.text.isNotEmpty){
        isActive=true;
      }
      setState(()  =>isActive = isActive );
    });

    voucherTypeDropdownBloc1 = VoucherTypeDropdownBloc();
    receivedByDropdownBloc = ReceivedByDropdownBloc();
    godownDropdownBloc = GodownDropdownBloc();
    voucherTypeDropdownBloc3 = VoucherTypeDropdownBloc();
    itemCostCenterDropdownBloc = ItemCostCenterDropdownBloc();
    dropdownBlocItemCurrentStatus = ItemCurrentStatusDropdownBloc();
    _amount = 0;
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => connectionStatus = result );
    });
    super.initState();
  }
  void clearData(){
    reqQty.clear();
  }

  @override
  void dispose() {
    reqQty.dispose();
    subscription.cancel();
    super.dispose();
  }
  void onDataChange1(VoucherType state) {
    setState(() {
      selectVoucherType1 = state;
    });
  }
  void onDataChange2(ReceivedBy state) {
    setState(() {
      selectReceivedBy = state;
    });
  }
  void onDataChange3(Godown state) {
    setState(() {
      selectGodown = state;
    });
  }
  void onDataChange4(ItemCostCenter state) {
    setState(() {
      selectItemCostCenter = state;
    });
  }
  void onDataChange5(ItemCurrentStatus state) {
    setState(() {
      selectItemCurrentStatus= state;
    });
  }

  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }
  verifyDetail(){
    if(connectionStatus == ConnectivityResult.wifi || connectionStatus == ConnectivityResult.mobile){
      if(selectVoucherType1!=null && selectReceivedBy!=null && selectGodown!=null && selectItemCostCenter!=null && extraWorkEntryFormKey1.currentState.validate()){
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
      await http.post(Uri.parse(ApiService.mockDataPostStockReceiveEntry),
          body: json.encode({
            "Voucher Type": selectVoucherType1.strName,
            "Received By": selectReceivedBy.Name,
            "Godown": selectGodown.GodName,
            "Cost Center":selectItemCostCenter.strName,
            "Item": selectItemCurrentStatus.strItemName,
            "ReqQuantity": reqQty.text,
            "Unit": selectItemCurrentStatus.strUnit,
            "Rate": selectItemCurrentStatus.dblQty,
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
    final bloc = StockReceiveEntryProvider.of(context);
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,

      child: SingleChildScrollView(
        child: Form(
          key: extraWorkEntryFormKey1,
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
                      onPressed: () {},
                      elevation: 0.0,
                      color: Colors.white,
                      child: raisedButtonText("Clear all"),
                    ),
                  ],
                ),
              ),
              formsHeadText("Voucher Type"),
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
                                padding: selectVoucherType1!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectVoucherType1,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<VoucherType>>((e) {
                                  return DropdownMenuItem<VoucherType>(
                                    value: e,
                                    child: Text(e.V_Type),
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
              formsHeadText("Received By"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52, width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ReceivedBy>>(
                    future: receivedByDropdownBloc.receivedByDropDownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ReceivedBy>(
                          stream: receivedByDropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<ReceivedBy>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectReceivedBy!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectReceivedBy,
                                displayClearIcon: false,
                                onChanged: onDataChange2,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<ReceivedBy>>((e) {
                                  return DropdownMenuItem<ReceivedBy>(
                                    value: e,
                                    child: Text(e.Name),
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
              formsHeadText("Godown"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52, width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<Godown>>(
                      // future: voucherTypeDropdownBloc3.voucherTypeDropdownData,
                    future: godownDropdownBloc.godownDropDownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<Godown>(
                            stream: godownDropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<Godown>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectGodown!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectGodown,
                                displayClearIcon: false,
                                onChanged: onDataChange3,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<Godown>>((e) {
                                  return DropdownMenuItem<Godown>(
                                    value: e,
                                    child: Text(e.GodName),
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
              formsHeadText("Choose your phase (Cost Centre)"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52, width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<ItemCostCenter>>(
                      future: itemCostCenterDropdownBloc.itemCostCenterData,
                      builder: (context, snapshot) {
                        return StreamBuilder<ItemCostCenter>(
                            stream: itemCostCenterDropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<ItemCostCenter>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectItemCostCenter!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectItemCostCenter,
                                displayClearIcon: false,
                                onChanged: onDataChange4,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<ItemCostCenter>>((e) {
                                  return DropdownMenuItem<ItemCostCenter>(
                                    value: e,
                                    child: Text(e.Name),
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

              // ----------------------------------------------
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
                                          onChanged: onDataChange5,
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
                            formsHeadText("Amount:"),
                          ],
                        ),
                        Row(
                          children: [
                            selectItemCurrentStatus!=null ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    height: 50, padding: padding1, decoration: decoration1(),
                                    child: Center(
                                        child: Text(selectItemCurrentStatus.dblQty))),
                              ),
                            ):
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                    height: 50, padding: padding1, decoration: decoration1(),
                                    child: const Center(
                                        child: Text("No"))),
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
                              onPressed: () {},
                              elevation: 0.0,
                              color: storeContainerColor,
                              child: raisedButtonText("Clear This Item"),

                            ),


                            // StreamBuilder<bool>(
                            // stream: bloc.submitCheck,
                            //   builder: (context, snapshot) {
                            //                    return
                            RoundedButtonInput(
                              text: "Add Item to List",
                              press: (selectItemCurrentStatus !=null)&&(isActive)? (){
                                _calculation();
                                setState(() {
                                  pressed = true;
                                });
                                clearData();
                              } :null,
                              fontsize1: 12,
                              size1: 0.5,
                              horizontal1: 30,
                              vertical1: 10,
                              color1: Colors.orange,
                              textColor1: textColor1,
                            ),
                            //  }
                            //),
                          ],
                        )
                      ],
                    ),

                  ),
                ),
              ),

              //-----------------------------------------------------------
              pressed? AddItemContainer(
                itemNameText: selectItemCurrentStatus.strItemName,
                orderQtyText: reqQty.text,
                rateText: selectItemCurrentStatus.dblQty,
                amountText: StringAmount.toString(),
              ) : const SizedBox(),

              sizedbox1,
              formsHeadText("Total Amount:"),
              sizedbox1,
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Submit",(){
                    verifyDetail();
                  },roundedButtonHomeColor1)),
            ],
          ),
        ),
      ),
    );

  }

}