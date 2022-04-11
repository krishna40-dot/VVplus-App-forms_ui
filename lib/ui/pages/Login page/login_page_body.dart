// Login page Ui

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:vvplus_app/Application/Bloc/Login_Bloc/login_page_bloc.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/screens/homepage/home_page.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/home%20page/staff_homepage.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({Key key}) : super(key: key);
  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final _phoneNumberFocusNode = FocusNode();
  final _otpFocusNode = FocusNode();

  @override
  void initState() {
    // Calling Phone number validation with BLoc
    _phoneNumberFocusNode.addListener(() {
      if (!_phoneNumberFocusNode.hasFocus) {
        context.read<LoginBloc>().add(PhoneNumberUnfocused());
        FocusScope.of(context).requestFocus(_otpFocusNode);
      }
    });
    // Calling OTP validation with BLoc
    _otpFocusNode.addListener(() {
      if (!_otpFocusNode.hasFocus) {
        context.read<LoginBloc>().add(OtpUnfocused());
      }
    });
    super.initState();
  }

  @override
  //dispose
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

//Widgets
  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return SingleChildScrollView(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submitting...')),
              );
          }
          if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submitting...')),
              );
          }
        },
        child: SafeArea(
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: primaryColor3,
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 47,
                    top: 39,
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
                    left: 240,
                    top: 25,
                  ),
                  child: Image.asset(
                    image2,
                    scale: 1.5,
                    height: 134,
                    width: 68,
                  ),
                ),
                _buildBottomPart(context),
              ],
            ),
          ),

        ),
      ),
    );
  }



  Widget _buildBottomPart(BuildContext context) {
    var width = SizeConfig.getWidth(context);
    return Padding(
      padding: const EdgeInsets.only(top: 228,left: 37),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text1,
              style: t1Style(),
            ),
            const SizedBox(height: 10,),
            Text(
              text2,
              style: simpleTextStyle2(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20,),
            Container(
              padding: padding2,
              color: primaryColor3,
              height: 51.0,
              child: PhoneNumberInput(focusNode: _phoneNumberFocusNode),
            ),
            const SizedBox(height: 20,),
            Text(
              text3,
              style: t2Style(),
              textAlign: TextAlign.center,
            ),
            Text(
              text4,
              style: t2Style(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 17,),
            Row(
              children: [
                Padding(
                  padding: padding3,

                  child: Text(
                    text5,
                    textAlign: TextAlign.center,
                    style: simpleTextStyle2(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              height: 55,
              width: 500,
              padding: padding2,
              decoration: decoration1(),
              child: Center(
                child: OtpInput(focusNode: _otpFocusNode),
              ),
            ),
            const SizedBox(height: 46,),
            Row(
              children: const [
                SubmitButton1(),
                SizedBox(width: 20,),
                SubmitButton2(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//Phone number text field class
class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({Key key,this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          style: phoneTextStyle(),
          initialValue: state.phoneNumber.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding: phoneTextFieldPadding,
            prefixIcon: phoneTextFieldPicker(),
            focusColor: textColor4,
            enabledBorder: outlineBorder(),
            focusedBorder: outlineBorder(),//floatingLabelBehavior: FloatingLabelBehavior.never,
            prefix: Padding(padding: phoneTextFieldPadding1),
            hintText: "Enter Mobile Number",
            //helperText:
            hintStyle: const TextStyle(color: primaryColor2,),
            errorText: state.phoneNumber.invalid ? 'Please ensure the number entered is valid' : null,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            context.read<LoginBloc>().add(PhoneNumberChanged(phone: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

//OTP text field class
class OtpInput extends StatefulWidget {
  final FocusNode focusNode;
  const OtpInput({Key key, this.focusNode}) : super(key: key);
  @override
  _OtpInputState createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  var focusNode;
  bool _obscureText;

  @override
  void initState() {
    _obscureText = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.otp.value,
          focusNode: focusNode,
          obscureText: !_obscureText,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.black45,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            labelStyle: const TextStyle(color: primaryColor4,),
            hintText: hintText2,
            hintStyle: const TextStyle(color: primaryColor4,),
            fillColor: primaryColor3,
            filled: true,
            enabledBorder: outlineBorder(),
            focusedBorder: outlineBorder(),
            prefix: Padding(padding: phoneTextFieldPadding1,),
            errorText: state.otp.invalid ? '''otp must be at least 5 characters''' : null,
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(OtpChanged(otp: value));
          },
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SubmitButton1 extends StatelessWidget {
  const SubmitButton1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RoundedButtonInput(
          color1: primaryColor1,
          fontsize1: 14,
          size1: 0.37,
          horizontal1: 30,
          vertical1: 17,
          press: () {Navigator.push(context, MaterialPageRoute(
              builder: (context) => const HomePage()));},
          text: "Sign In",
        );
      },
    );
  }
}

//Submit button class
class SubmitButton2 extends StatelessWidget {
  const SubmitButton2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RoundedButtonInput(
          color1: primaryColor1,
          fontsize1: 14,
          size1: 0.37,
          horizontal1: 30,
          vertical1: 17,
          press: () {Navigator.push( context, MaterialPageRoute(
              builder: (context) => const HomePageStaff()));},
          text: "Sign In Staff",
        );
      },
    );
  }
}