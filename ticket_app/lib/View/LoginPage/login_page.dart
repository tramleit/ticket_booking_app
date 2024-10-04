

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/View/LoginPage/widget/login_widget.dart';

import '../../ViewModel/BloC/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF1E192B),
          body: Provider.value(value: AuthenticationBloc(), child: const LoginWidget()),
        )
    );
  }
}
