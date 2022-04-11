import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';

AppBar appBarMain(String appBarText) {
  return AppBar(
    centerTitle: true,
    title: Text(
      appBarText,
      style: const TextStyle(fontSize: 34.0, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
    toolbarHeight: 107,
    titleTextStyle: const TextStyle(color: primaryColor3),
    backgroundColor: primaryColor1,
  );
}