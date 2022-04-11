import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:http/http.dart' as http;

class PlacePurchaseOrderContainerData extends StatefulWidget {
  const PlacePurchaseOrderContainerData({Key key}) : super(key: key);

  @override
  _PlacePurchaseOrderContainerDataState createState() =>
      _PlacePurchaseOrderContainerDataState();
}

class _PlacePurchaseOrderContainerDataState extends State<PlacePurchaseOrderContainerData> {

  List data;

  fetchData1() async {

    http.Response response =
    await http.get(Uri.parse(ApiService.mockDataPostMaterialRequestEntryURL));
    setState(() {
      data = json.decode(response.body);
    });
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
        : SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){print("no");},
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Container(
                  alignment: Alignment.center,
                  height: 108,
                  width: SizeConfig.getWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: primaryColor3,
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
                              data[index]['ItemName'],
                              style: containerTextStyle1(),
                            ),
                            const SizedBox(height: 13,),
                            Text(
                              data[index]['ItemSubCode'],
                              style: containerTextStyle4(),
                            ),
                            const SizedBox(height: 2,),
                            Row(
                              children: [
                                Text(
                                  "Order no.:",
                                  style: containerTextStyle3(),
                                ),
                                Text(
                                  data[index]['ReqQty'],
                                  style: containerTextStyle3(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17, top: 13),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Order Qty.:\nReceive Qty.:\nRate:\nAmount:",
                                    style: containerTextStyle2(),
                                  ),
                                  Text(
                                    "Remarks:",
                                    style: containerTextStyle4(),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 15),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index]['ReqQty'],
                                        style: containerTextStyle2(),
                                      ),
                                      Text(
                                        data[index]['ReqQty'],
                                        style: containerTextStyle2(),
                                      ),
                                      Text(
                                        data[index]['Rate'],
                                        style: containerTextStyle2(),
                                      ),
                                      Text(
                                        data[index]['Rate'],
                                        style: containerTextStyle2(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(icon15),
                                      const SizedBox(height: 15.5,),
                                      Text(
                                        "Edit",
                                        style: containerTextStyle5(),
                                      ),
                                      const SizedBox(height: 7,),
                                      Text(
                                        "Inc.Tax",
                                        style: containerTextStyle3(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}