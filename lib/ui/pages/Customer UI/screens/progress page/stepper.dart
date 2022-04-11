// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/Customer_Bloc/Stepper_bloc/stepper_bloc.dart';
import 'package:vvplus_app/ui/Pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/Pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';


class StepperBody extends StatefulWidget {
  const StepperBody({Key key}) : super(key: key);
  @override
  StepperBodyState createState() => StepperBodyState();
}

class StepperBodyState extends State<StepperBody> {

  int currentStep = 2;
  StepperBloc _stepperBloc;

  @override
  void initState() {
    _stepperBloc = StepperBloc();
    super.initState();
  }

  @override
  void dispose() {
    _stepperBloc.dispose();
    super.dispose();
  }

  List<Step> steps = [
    Step(
      //state: StepState.complete,
      title: const Text(text27,style: TextStyle(color: Colors.black45),),
      content: Container(
        alignment: Alignment.centerLeft,
      ),
      // isActive: true,
    ),
    Step(
      //state: StepState.complete,
      title: const Text(text29,style: TextStyle(color: Colors.black45),),
      content: Container(
        alignment: Alignment.centerLeft,
      ),
      // isActive: true,
    ),
    Step(
      //state: StepState.complete,
      title: const Text(text31),
      content: Column(
        children: [
          Text(
            text32,
            style: Stepperstyle(),
          ),
          const Text(
            text37,
          ),


          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

          GestureDetector(
            onTap: (){
              // directing page
            },
            child: Container(
              height: 84,
              width: 250,
              decoration: decoration4(Colors.red),
              alignment: Alignment.center,
              child: const Text(text33,
                textAlign: TextAlign.center,
                style: TextStyle(color: primaryColor3,fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          GestureDetector(
            onTap: (){
              // directing page
            },
            child: Container(
              height: 84,
              width: 250,
              decoration: decoration4(primaryColor7),
              alignment: Alignment.center,
              child: const Text(text34,
                textAlign: TextAlign.center,
                style: TextStyle(color: primaryColor3,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      //state: StepState.complete,
      isActive: true,
    ),
    Step(
      //state: StepState.complete,
      title: const Text(text35),
      content: Container(
          alignment: Alignment.centerLeft,
          child: const Text(text36)),
      // state: StepState.complete,
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Theme(
                    data: ThemeData(
                        accentColor: stepperColor1,
                        primarySwatch: stepperColor1,
                        colorScheme: const ColorScheme.light(
                          primary: stepperColor,

                        )
                    ),
                    child: StreamBuilder<int>(
                      stream: _stepperBloc.getStep,
                      initialData: 0,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Stepper(
                            physics: const NeverScrollableScrollPhysics(),
                            currentStep: snapshot.data,
                            steps: steps,
                            type: StepperType.vertical,
                            onStepTapped: (step) {_stepperBloc.goTo(step);},
                            onStepContinue: () {_stepperBloc.next(steps.length);},
                            onStepCancel: () {_stepperBloc.cancel;},
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
    );
        }
  }