

import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class MyEvent{}

class FetchMovies extends MyEvent{}

class FetchBanner extends MyEvent{}

class OrderSeat extends MyEvent{

  Object? data;
  BuildContext context;
  OrderSeat({this.data, required this.context});

}
class AddMovie extends MyEvent{
  Object? data;
  BuildContext context;
  File imageAssets;
  File imageBanner;
  AddMovie({required this.data, required this.context, required this.imageAssets, required this.imageBanner});
}
class DeleteMovie extends MyEvent{
  BuildContext context;
  String id;

  DeleteMovie({required this.context, required this.id});
}

class EditMovie extends MyEvent {
  final Map<String, dynamic> data;
  final BuildContext context;
  final String imageAsset;
  final String imageBanner;

  EditMovie({
    required this.data,
    required this.context,
    required this.imageAsset,
    required this.imageBanner,

  });
}
class LoginEvent extends MyEvent{
  String username;
  String password;
  BuildContext context;
  LoginEvent({required this.context, required this.username, required this.password});
}

class RegisterEvent extends MyEvent{
  String username;
  String password;
  String repassword;
  BuildContext context;

  RegisterEvent({required this.context, required this.username, required this.password, required this.repassword});
}