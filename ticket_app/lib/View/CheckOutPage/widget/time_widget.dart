
import 'package:flutter/material.dart';
import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/time_model.dart';


import '../../../ViewModel/BloC/movie_controller.dart';

class MyTime extends StatefulWidget {

  final Function(int, TimeModel) onPressed;
  final int selectTime;
  final DateModel dateSelect;

  const MyTime({Key? key, required this.onPressed, required this.selectTime, required this.dateSelect}) : super(key: key);

  @override
  State<MyTime> createState() => _MyTimeState();
}

class _MyTimeState extends State<MyTime> {



  @override
  Widget build(BuildContext context) {

    final myTime = MovieController.listTime.where((item) {
      return item.idDate == widget.dateSelect.id;
    }).toList();

    return ListView.builder(
        itemCount: myTime!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return mainDate(myTime![index], index);
        }
    );
  }
  Widget mainDate(TimeModel myDate, int index){
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ()=>widget.onPressed(index, myDate),
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 7, right: 3),
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.white, width: 1),
            color: widget.selectTime == index ? Colors.deepPurpleAccent : null
        ),
        child: Center(
          child: Text(
            myDate.name.toString(),
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                overflow: TextOverflow.ellipsis
            ),
          ),
        ),

      ),
    );
  }
}
