// Login Page for the Application

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Login_Bloc/login_page_bloc.dart';
import 'package:vvplus_app/ui/pages/Login%20page/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => LoginBloc(),
          child: const LoginPageBody(),
        ),
      ),
    );
  }
}