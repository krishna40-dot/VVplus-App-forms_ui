import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

showAlertDialog(BuildContext context) {

  Widget okButton = TextButton(
    child: Center(
        child: Container(
          height: 22,
            width: 48,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: const Text("Cancel",style: TextStyle(fontSize: 14,color: Colors.white),))),
    onPressed: () {Navigator.of(context).pop(); },
  );

  AlertDialog alert = AlertDialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
    ),
    //title: Image.asset(icon16),
    content: SizedBox(
      height: SizeConfig.getHeight(context) * 0.5,
        width: SizeConfig.getWidth(context) * 0.5,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 55.5,),
            Image.asset(icon16),
            const SizedBox(height: 28.5,),
            const Padding(
              padding: EdgeInsets.only(left: 32,right: 32),
              child: Center(
                child: Text("Your request for to branch transfer has been sent to corporate.E-way bill has been requested automatically too.",
                  style: TextStyle(fontSize: 20,color: Colors.black),),
              ),
            ),
          ],
        )),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}