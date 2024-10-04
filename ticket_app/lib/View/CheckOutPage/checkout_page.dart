

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/seat_model.dart';
import 'package:ticket_app/Model/time_model.dart';
import 'package:ticket_app/View/CheckOutPage/widget/date_widget.dart';
import 'package:ticket_app/View/CheckOutPage/widget/seat_widget.dart';
import 'package:ticket_app/View/CheckOutPage/widget/time_widget.dart';
import 'package:ticket_app/ViewModel/BloC/movie_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/movie_controller.dart';
import 'package:ticket_app/ViewModel/BloC/my_event.dart';
import 'package:ticket_app/ViewModel/service.dart';
import 'package:ticket_app/ViewModel/utill.dart';

import '../../Model/checkout_model.dart';
import '../../Model/movie_model.dart';


class MainCheckOutPage extends StatefulWidget {
  const MainCheckOutPage({super.key});

  @override
  State<MainCheckOutPage> createState() => _MainCheckOutPageState();
}

class _MainCheckOutPageState extends State<MainCheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: MovieBloc,
      child: const CheckoutPage(),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieModel movie = Get.arguments;
    print(movie.title.toString());
    return ChangeNotifierProvider(
        create: (context) => CheckOutModel(
            movieModel: movie,
            dateSelect: DateModel(),
            timeSelect: TimeModel(),
            seatSelect: SeatModel()
        ),
        child: Provider<MovieBloc>.value(
          value: MovieBloc(),
            child: const MyCheckOut()
        ),
    );
  }
}

class MyCheckOut extends StatefulWidget {

  const MyCheckOut({super.key});

  @override
  State<MyCheckOut> createState() => _MyCheckOutState();
}

class _MyCheckOutState extends State<MyCheckOut> {


  @override
  Widget build(BuildContext context) {
    final checkOut = Provider.of<CheckOutModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1E192B),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left:  10),
              width: 30,
              height: 30,
              //color: Colors.red,
              child: InkWell(
                onTap: (){
                  Get.back();
                },
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 27,)
              ),
            ),
            const SizedBox(height: 10,),

            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Select Date',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white

                ),
              ),
            ),

            // Draw Date
            Container(
              margin: EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              height: 40,
            //  color: Colors.red,
              child: MyDate(
                onPressed: (index, myDate) {
                  checkOut.updateDate(index, myDate);
                }, selectDate: checkOut.selectDate,movieSelect: checkOut.movieModel,
              ),
            ),
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Select Time',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white

                ),
              ),
            ),

            // Draw Date
            Container(
              margin: EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              height: 40,
              //  color: Colors.red,
              child: MyTime(
                onPressed: (index, mytime) {

                  checkOut.updateTime(index, mytime);

                }, selectTime: checkOut.selectTime, dateSelect: checkOut.dateSelect,
              ),
            ),
            SizedBox(height:  30,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Select Seat',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
             // color: Colors.red,
              child: MySeat(
                onPressed: (myseat, index, dateslect, timeslect) {
                  checkOut.updateSeat(index, myseat, dateslect, timeslect);
                }, movieSelect: checkOut.movieModel ,selectSeat: checkOut.selectSeat, dateSelect: checkOut.dateSelect, timeSelect: checkOut.timeSelect,
              ),
            ),

            Container(
              margin: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.white)

              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [

                        Text(
                          "Seat: ${checkOut.resultSeat}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Price: ${checkOut.resultPrice}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),

                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        checkOut.getData(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          elevation: 0,

                          backgroundColor: const Color(0xFF8A6ADE)

                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.airplane_ticket_outlined, color:  Colors.white, size: 17,),
                          SizedBox(width: 5,),
                          Text(
                            'Buy now',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white
                            )
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

}

