import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/Customer_Bloc/NewComplaint_Bloc/new_complaint_bloc.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/screens/NewComplaint%20page/new_complaint_page_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';

class NewComplaintPage extends StatelessWidget{
  const NewComplaintPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewComplaintPageProvider(
      child: Scaffold(
        appBar: appBarSatff("New Complaint Page"),
        body: const NewComplaintPageBody(),
      ),
    );

  }

}