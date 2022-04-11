import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/home%20page/staff_homepage_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class HomePageStaff extends StatefulWidget{
  const HomePageStaff({Key key}) : super(key: key);

  @override
  State<HomePageStaff> createState() =>MyHomePageStaff();
 }

class MyHomePageStaff extends State<HomePageStaff> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: HomeBody(),
      bottomNavigationBar: BottomNavBarStaff(),
    );
  }
}

