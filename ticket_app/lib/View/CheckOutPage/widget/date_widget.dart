
import 'package:flutter/material.dart';
import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/ViewModel/BloC/movie_controller.dart';


class MyDate extends StatefulWidget {

  final Function(int, DateModel) onPressed;
  final int selectDate;
  final MovieModel movieSelect;

  const MyDate({Key? key, required this.onPressed, required this.selectDate, required this.movieSelect}) : super(key: key);

  @override
  State<MyDate> createState() => _MyDateState();
}

class _MyDateState extends State<MyDate> {

  @override
  Widget build(BuildContext context) {
    final myDate = MovieController.listDate;
    //print('Giá trị select = ${widget.selectDate}');
    return ListView.builder(
      itemCount: myDate.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return mainDate(myDate[index], index);
        }
    );
  }
  Widget mainDate(DateModel myDate, int index){
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
          color: widget.selectDate == index ? Colors.deepPurpleAccent : null
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
