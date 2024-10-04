

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ticket_app/Model/response_model.dart';
import 'package:ticket_app/Model/users_model.dart';
import 'package:ticket_app/View/HomePage/home_page.dart';
import 'package:ticket_app/ViewModel/BloC/base_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/my_event.dart';
import 'package:ticket_app/ViewModel/service.dart';

import '../utill.dart';

class AuthenticationBloc extends BaseBloc{

  ServiceRepository repository = ServiceRepository();
  static late UsersModel users;


  @override
  void dispatchEvent(MyEvent event) {
    // TODO: implement dispatchEvent
    if(event is LoginEvent){
      print('Loginnnn');
      authLogin(event.context, event.username, event.password);

    }
    if(event is RegisterEvent){
      print('Register');
      registerAuth(event.context, event.username, event.password, event.repassword);
    }
  }
  void authLogin(BuildContext context, String user, String pass) async{
    ResponseModel res = await repository.loginUser(user, pass);
    if(res != null){
      if (res.users != null) {
        users = res.users!;
      }
      if(res.status == 1){
        Get.to(
            ()=> const HomePage(),
          duration: const Duration(milliseconds: 300),
          transition: Transition.fade
        );
      }else{
        Utill.showSimpleDialog(context, res.message);
      }
    }
    else{
      Utill.showSimpleDialog(context, "Có lỗi xảy ra");
    }
  }
  void registerAuth(BuildContext context, String user, String pass, String repass) async{
    ResponseModel res = await repository.registerUser(user, pass, repass);
    if(res != null){
      if(res.users != null){
        //users = res.users!;
      }
      Utill.showSimpleDialog(context, res.message.toString());
    }
    else{
      Utill.showSimpleDialog(context, "Có lỗi xảy ra");
    }
  }
}