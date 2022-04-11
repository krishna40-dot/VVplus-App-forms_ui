import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/Branch%20to%20Branch%20Receive/branch_to_branch_receive_home.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/Branch%20to%20Branch%20Send/branch_to_branch_send_home.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/Phase%20to%20Phase%20Transfer/phase_to_phase_transfer_home.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/stock%20issue%20entry/store_issue_entry_home.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/stock%20receive%20entry/stock_receive_entry_home.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';

class StorePageBody extends StatelessWidget{
  final Widget child;

  const StorePageBody({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: paddingForms3,
            child: Container(
              alignment: Alignment.center,
              height: 130,
              width: 300,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      "Notification",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Padding(padding: paddingForms2),
              roundedButtonHome(text42,
                      () {Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const StockReceiveEntryPage()));
                      }),
              roundedButtonHome(text43,
                      () {Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const StockIssueEntryPage()));}),
              roundedButtonHome(text44,
                      () {Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const PhaseToPhaseTransferPage()));}),
              roundedButtonHome(text45,
                      () {Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const BranchtoBranchSendPage()));}),
              roundedButtonHome(text46,
                      () {Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const BranchtoBranchReceivePage()));}),
            ],
          ),
        ],
      ),
    );
  }

}