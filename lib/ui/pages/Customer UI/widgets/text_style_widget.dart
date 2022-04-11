// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';

TextStyle simpleTextStyle(var color1 , double size1) {
  return TextStyle(color: color1, fontSize: size1 ,fontWeight: FontWeight.bold,);
}


TextStyle t1Style() {
  return simpleTextStyle(primaryColor2,18);
}
TextStyle t2Style() {
  return simpleTextStyle(primaryColor2,11);
}
TextStyle simpleTextStyle1() {
  return simpleTextStyle(primaryColor3,18);
}

TextStyle simpleTextStyle4() {
  return const TextStyle(fontSize: 12);
}

TextStyle simpleTextStyle5() {
  return simpleTextStyle(primaryColor2,18);
}
TextStyle simpleTextStyle6() {
  return simpleTextStyle(primaryColor1,18);
}
TextStyle simpleTextStyle7() {
  return simpleTextStyle(primaryColor2,16);
}

TextStyle simpleTextStyle9(var color1,double size1) {
  return TextStyle(color: color1, fontSize: size1 );
}

TextStyle simpleTextStyle10(var colorof) {
  return TextStyle(color: colorof, fontSize: 14, fontWeight: FontWeight.bold);
}
TextStyle ContainerHeading1() {
  return simpleTextStyle(textColor2,18);
}
TextStyle containerHeading2() {
  return simpleTextStyle(textColor3,18);
}
TextStyle ContainerText2() {
  return const TextStyle(
      color: textColor4, fontSize: 14);
}
TextStyle ContainerText2Bold() {
  return simpleTextStyle(textColor4,14);
}
TextStyle simpleTextStyle2() {
  return simpleTextStyle9(primaryColor2,18 );
}

TextStyle Stepperstyle() {
  return simpleTextStyle(textColor3, 15);
}
TextStyle phoneTextStyle(){
  return const TextStyle(color: textColor4, decorationColor: decorationColor1,);
}