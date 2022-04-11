import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:readmore/readmore.dart';


class HouseInformation extends StatefulWidget {
  const HouseInformation({Key key}) : super(key: key);

  @override
  _HouseInformationState createState() => _HouseInformationState();
}

class _HouseInformationState extends State<HouseInformation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: SingleChildScrollView(
        child: Column(

        //width: width,
        //height: height,
        //decoration: const BoxDecoration(
          //color: PrimaryColor3,
       // ),
        children:[
          Stack(
          children: <Widget>[
        Padding(
        padding: const EdgeInsets.only(
          left: 47,
          top: 10,
        ),
        child: Image.asset(
           image1,
          scale: 1.5,
          height: 241,
          width: 286,
        ),
    ),
            Padding(
              padding: const EdgeInsets.only(
                left: 255,
                top: 25,
              ),
              child: Image.asset(
                image2,
                scale: 1.5,
                height: 134,
                width: 68,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 41,right: 35,
                  top: 180,
                ),
                child: Image.asset("assets/images/kisspng-villa-house.png")),
            Padding(
              padding: const EdgeInsets.only(
                left: 41,right: 35,
                top: 310,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "How our house is vastu",
                      style: TextStyle(color: Colors.black,fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40,),
                    const Text(
                      "You will receive an SMS verification that may apply message and data rates. You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.You will receive an SMS verification that may apply message and data rates.",
                      style: TextStyle(color: Colors.black45,fontSize: 12),
                    ),
                const Padding(
                  padding: EdgeInsets.only(
                    right: 115,
                    //top: 310,
                  ),
                  child: ReadMoreText(
                    'Flutter is Googlwork to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                    trimLines: 2,
                    colorClickableText: Colors.black,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Read less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.green),
                  ),
                ),
                    Row(
                      children: [
                        roundedButton3("Next",(){}),
                        const SizedBox(width: 25,),
                        roundedButton3("Skip",(){}),
                      ],
                    ),
                  ],
              ),
            ),
          ],
        ),
          ],
    ),
      ),
    ),
    );
  }
}