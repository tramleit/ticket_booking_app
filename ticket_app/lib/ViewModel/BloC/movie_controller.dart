

import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/seat_model.dart';
import 'package:ticket_app/Model/seat_order_model.dart';
import 'package:ticket_app/Model/time_model.dart';
import 'package:ticket_app/ViewModel/BloC/base_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/my_event.dart';
import 'package:ticket_app/ViewModel/service.dart';

class MovieController{

  final ServiceRepository _serviceRepository = ServiceRepository();
  static List<DateModel> listDate = [];
  static List<TimeModel> listTime = [];
  static List<SeatModel> listSeat = [];
  static List<SeatOrderModel> listSeatOrder = [];

  void loadMovieController(){
    print('Get Movies Controller');
    getDate();
    getTime();
    getSeat();
    getSeatOrder();
  }

  void getDate() async{
    var data = await _serviceRepository.fetchDate();
    if(data.isNotEmpty){
      listDate = data;
    }
  }
  void getTime() async{
    var data = await _serviceRepository.fetchTime();
    if(data.isNotEmpty){
      listTime = data;
    }
  }
  void getSeat() async{
    var data = await _serviceRepository.fetchSeat();
    if(data.isNotEmpty){
      listSeat = data;
    }
  }
  void getSeatOrder() async{
    var data = await _serviceRepository.fetchSeatOrder();
    if(data.isNotEmpty){
      listSeatOrder = data;
    }
  }
}