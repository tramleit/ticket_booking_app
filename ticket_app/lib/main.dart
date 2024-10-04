import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ticket_app/Router/routers.dart';

import 'View/HomePage/home_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SafeArea(
        child: Scaffold(

          body: MyHomePage(),
        ),
      ),
      initialRoute: RouteController.login,
      getPages: RouteController.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

