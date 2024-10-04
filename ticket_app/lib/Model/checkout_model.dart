

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/Model/seat_model.dart';
import 'package:ticket_app/Model/time_model.dart';

import '../ViewModel/BloC/movie_bloc.dart';
import '../ViewModel/BloC/my_event.dart';
import '../ViewModel/utill.dart';
import 'date_model.dart';
import 'movie_model.dart';

class CheckOutModel extends ChangeNotifier{
  int selectDate = 0;
  int selectTime = 0;
  int selectSeat = 0;
  DateModel dateSelect;
  TimeModel timeSelect;
  SeatModel seatSelect;
  MovieModel movieModel;
  CheckOutModel(
      {
        required this.movieModel,
        required this.dateSelect,
        required this.timeSelect,
        required this.seatSelect,
      });

  String resultSeat = '';
  String resultPrice = '';

  void updateDate(int index, DateModel date){
    selectDate = index;
    dateSelect = date;
    notifyListeners();
  }
  void updateTime(int index, TimeModel time){
    selectTime = index;
    timeSelect = time;
    notifyListeners();
  }
  void updateSeat(int index, SeatModel seat, DateModel date, TimeModel time){
    selectSeat = index;
    seatSelect = seat;
    resultSeat = seat.name.toString();
    resultPrice = seat.price.toString();
    notifyListeners();
  }

  void getData(BuildContext context){
    // Buy now
    final bloc = Provider.of<MovieBloc>(context, listen: false);
    var data = {
      "id" : "Order_ ${Utill.generateRandomString(10)}",
      "username" : "KTPM K20D",
      "price" : seatSelect.price,
      "idSeat" : seatSelect.id,
      "idDate" : dateSelect.id,
      "idTime": timeSelect.id,
      "idMovie": movieModel.id
    };
    bloc.event.add(OrderSeat(data: data, context: context));
    bloc.event.add(FetchMovies());
    notifyListeners();


  }
}