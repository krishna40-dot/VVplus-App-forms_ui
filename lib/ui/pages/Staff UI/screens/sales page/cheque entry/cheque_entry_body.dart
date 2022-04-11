import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/cheque%20entry/Custom_Tab_Bar_Item/cleared.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/cheque%20entry/Custom_Tab_Bar_Item/deposit.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/cheque%20entry/Custom_Tab_Bar_Item/receive.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/cheque%20entry/custom_tab_bar.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';

class ChequeEntryBody extends StatefulWidget {
  const ChequeEntryBody({Key key}) : super(key: key);
  @override
  State<ChequeEntryBody> createState() => _ChequeEntryBody();
}
class _ChequeEntryBody extends State<ChequeEntryBody> {

  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: SizedBox(
                height: 1000,
                child: Stack(
                  children: [

                    const TabBarView(children: [

                      ChequeEntryReceiveBody(),

                      ChequeEntryDepositBody(),

                      ChequeEntryClearedBody(),
                    ],
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 60),
                      child: CustomTabBar(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}