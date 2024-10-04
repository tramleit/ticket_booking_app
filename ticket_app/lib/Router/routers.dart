

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ticket_app/View/DetailPage/detail_page.dart';
import 'package:ticket_app/View/HistoryPage/history_page.dart';
import 'package:ticket_app/View/HomePage/home_page.dart';
import 'package:ticket_app/View/LoginPage/login_page.dart';
import 'package:ticket_app/View/RegisterPage/register_page.dart';

import '../View/AdminPage/Widget/edit_movie.dart';
import '../View/AdminPage/Widget/movie_page.dart';
import '../View/AdminPage/admin_movie_control.dart';
import '../View/CheckOutPage/checkout_page.dart';

class RouteController{
  static String home = '/';
  static String setting = '/detail';
  static String checkout = '/checkout';
  static String history = '/history';
  static String admin = '/admin';
  static String editmovie = '/editmovie';
  static String login = '/login';
  static String register = '/register';

  static List<GetPage> routes = [
    GetPage(name: home, page: ()=> const MyHomePage()),
    GetPage(name: setting, page: ()=> const MyDetailPage()),
    GetPage(name: checkout, page: ()=> const CheckoutPage()),
    GetPage(name: history, page: ()=> const HistoryPage()),
    GetPage(name: admin, page: ()=> const AdminPage()),
    GetPage(name: editmovie, page: () => const EditMoviePage()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: register, page: () => const RegisterPage())
  ];
}