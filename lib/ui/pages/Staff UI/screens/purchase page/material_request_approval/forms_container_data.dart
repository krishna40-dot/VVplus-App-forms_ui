// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/domain/common/common_text.dart';
import 'package:vvplus_app/domain/common/snackbar_widget.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'dart:convert';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class MaterialApprovalPageContainerData extends StatefulWidget {
  const MaterialApprovalPageContainerData({Key key}) : super(key: key);

  @override
  _MaterialApprovalPageContainerDataState createState() =>
      _MaterialApprovalPageContainerDataState();
}

class _MaterialApprovalPageContainerDataState
    extends State<MaterialApprovalPageContainerData> {
  List data;
  bool isActive = false;
  bool pressed = false;
  bool post = true;

  TextEditingController intendDateInput = TextEditingController();
  TextEditingController reqDateInput = TextEditingController();
  TextEditingController indentType = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController reqQty = TextEditingController(text:'0');
  TextEditingController rate = TextEditingController();
  TextEditingController costCenter = TextEditingController();
  TextEditingController remarks = TextEditingController();


  IndentorName selectIndentName;
  ItemCurrentStatus selectItemCurrentStatus;
  ItemCostCenter selectItemCostCenter;

  fetchData1() async {
    http.Response response = await http.get(Uri.parse(ApiService.mockDataPostMaterialRequestEntryURL));
    setState(() {
      data = json.decode(response.body);
    });
  }

  Future<dynamic> sendData() async{
    try {
      await http.post(Uri.parse("https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/ApprovedMaterialData/0.json"),
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

  @override
  void initState() {
    fetchData1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : post?SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isActive = true;
                        isActive = isActive;
                        pressed = true;
                      });
                      print("no");
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        alignment: Alignment.center,
                        height: 92,
                        width: SizeConfig.getWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: pressed?Colors.blue[200]:primaryColor3,
                          boxShadow: const [
                            BoxShadow(
                              color: primaryColor5,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 10),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data[index]['IndentSubCode'],
                                    style: containerTextStyle1(),
                                  ),
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Order Qty.:",
                                        style: containerTextStyle2(),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40),
                                        child: Text(
                                          data[index]['ReqQty'],
                                          style: containerTextStyle2(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 13),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Dept:",
                                            style: containerTextStyle3(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Req Date:",
                                        style: containerTextStyle2(),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Indentor:",
                                        style: containerTextStyle2(),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Indent No.:",
                                        style: containerTextStyle2(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4, top: 13),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Store",
                                            style: containerTextStyle3(),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50),
                                              child: Image.asset(icon15)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        data[index]['ReqDate'],
                                        style: containerTextStyle2(),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        data[index]['ItemName'],
                                        style: containerTextStyle2(),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        data[index]['ItemSubCode'],
                                        style: containerTextStyle2(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },

              ),
              sizedbox1,
              SizedBox(
                width: 343,
                height: 51,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      primary: primaryColor1,
                      onSurface: primaryColor1,
                    ),
                    onPressed: isActive ? () {
                      //sendData();
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>AlertDialog(
                        content: Text("Do you want to approve the selected Datas"),
                        actions: [
                          FlatButton(
                              onPressed: (){
                                setState(() {
                                  post = false;
                                  Navigator.pop(context, 'Cancel');
                                });
                              },
                              child: Text("yes")),
                          FlatButton(
                              onPressed: (){
                                Navigator.pop(context, 'Cancel');
                              },
                              child: Text("No")),
                        ],
                      ),);
                    } : null,
                    child: const Text("Approve")),
              ),
              sizedbox1,
              SizedBox(
                width: 343,
                height: 51,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      primary: primaryColor6,
                      onSurface: primaryColor6,
                    ),
                    onPressed: isActive ? () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>AlertDialog(
                          content: Text("Do you want to delete the selected Datas"),
                          actions: [
                            FlatButton(
                                onPressed: (){
                                  setState(() {
                                    post = false;
                                    Navigator.pop(context, 'Cancel');
                                  });
                                  final snackBar = SnackBar(
                                    content: const Text('Data delected succesfully'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );

                                  // Find the ScaffoldMessenger in the widget tree
                                  // and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                                child: Text("yes")),
                            FlatButton(
                                onPressed: (){
                                  Navigator.pop(context, 'Cancel');
                                },
                                child: Text("No")),
                          ],
                        ),);
                    } : null,
                    child: const Text("Deny")),
              ),
              sizedbox1,
              SizedBox(
                width: 343,
                height: 51,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      primary: primaryColor5,
                      onSurface: primaryColor5,
                    ),
                    onPressed: isActive ? () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>AlertDialog(
                          content: Text("Datas are set to wait"),
                          actions: [
                            FlatButton(
                                onPressed: (){
                                  setState(() {
                                    pressed = false;
                                    Navigator.pop(context, 'Cancel');
                                  });
                                },
                                child: Text("Ok")),

                          ],
                        ),);
                    } : null,
                    child: const Text("Wait")),
              ),
              sizedbox1,
            ]),
          ):SizedBox(
      height: 50,
        child: Center(
            child: Text("No records to show")));
  }

}
