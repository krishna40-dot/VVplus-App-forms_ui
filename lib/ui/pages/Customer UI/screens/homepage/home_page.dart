import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/screens/homepage/body.dart';
import '../../widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget{
  const HomePage({
    Key key
  }): super(key:key);
  @override
  State<HomePage> createState()=>MyHomePage();
}

class MyHomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: BottomNavBar()
    );
  }
}
