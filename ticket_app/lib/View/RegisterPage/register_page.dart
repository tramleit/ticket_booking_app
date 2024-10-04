

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ticket_app/View/RegisterPage/widget/register_widget.dart';

import '../../ViewModel/BloC/authentication_bloc.dart';

class RegisterPage extends StatefulWidget {


  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  AuthenticationBloc bloc = Get.arguments;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF1E192B),
          body: RegisterWidget(bloc: bloc),
        )
    );
  }
}
