import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/screens/view%20house%20page/view_house_body.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';


class ViewHouse extends StatelessWidget{
  const ViewHouse({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: const Text("View house",
      style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w600),
    ),
    toolbarHeight: 107,
    titleTextStyle: const TextStyle(color: primaryColor3),
    backgroundColor: primaryColor1,
    centerTitle: true,
  ),
  body: const ViewHouseBody(),
);
  }

}