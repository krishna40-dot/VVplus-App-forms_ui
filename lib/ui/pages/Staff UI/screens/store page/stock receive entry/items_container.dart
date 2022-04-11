// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'dart:convert';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class Page1 extends StatefulWidget {
  const Page1({Key key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List data;

  fetchData1() async {

    http.Response response =
    await http.get(Uri.parse(ApiService.mockDataPostItemDetail));
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
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){print("no");},
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.center,
                height: 92,
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
                            data[index]['Item'],
                            style: containerTextStyle1(),
                          ),
                          const SizedBox(height: 13,),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[

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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[


                              const SizedBox(height: 2,),

                              Row(
                                children:[
                                  Text(
                                    "Receive Qty.:",
                                    style: containerTextStyle2(),
                                  ),
                                  Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    data[index]['ReqQuantity'],
                                    style: containerTextStyle2(),
                                  ),
                                ),
              ]
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children:[
                                  Text(
                                  "Rate:",
                                  style: containerTextStyle2(),
                                ),
                                  const SizedBox(width: 50),
                                  Text(
                                    data[index]['Rate'],
                                    style: containerTextStyle2(),
                                  ),
                      ]
                              ),
                              const SizedBox(height: 2,),
                              Row(
                                children: [
                                  Text(
                                  "Amount:",
                                  style: containerTextStyle2(),
                                ),
                              const SizedBox(width: 30),

                              Text("",
                                //data[index]['ItemName'],
                                style: containerTextStyle2(),
                              ),
                                  ]
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 13),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Image.asset(icon15)),
                                ],
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
        itemCount: data == null ? 0 : data.length,
      ),
    );
  }
}