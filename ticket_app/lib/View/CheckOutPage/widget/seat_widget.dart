
import 'package:flutter/material.dart';
import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/Model/seat_model.dart';
import 'package:ticket_app/Model/time_model.dart';
import 'package:ticket_app/ViewModel/BloC/movie_controller.dart';


class MySeat extends StatefulWidget {

  final Function(SeatModel,int, DateModel, TimeModel) onPressed;
  final int selectSeat;
  final DateModel dateSelect;
  final TimeModel timeSelect;
  final MovieModel movieSelect;
  const MySeat({Key? key,required this.movieSelect, required this.onPressed, required this.selectSeat, required this.dateSelect, required this.timeSelect}) : super(key: key);

  @override
  State<MySeat> createState() => _MySeatState();
}

class _MySeatState extends State<MySeat> {



  @override
  Widget build(BuildContext context) {
    print('Time Selected: ${widget.timeSelect.id}');
    print('Date Selected: ${widget.dateSelect.id}');
    final mySeat = (widget.timeSelect.id != null && widget.dateSelect.id != null) ? MovieController.listSeat : [];
    return Container(
      height: 250,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(20)
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: 7,
          mainAxisSpacing: 7,
          childAspectRatio: 1,
        ),
        itemCount: mySeat.length,
          itemBuilder: (context, index) {
            return MainSeat(mySeat[index], index);
          },
      ),
    );
  }

  Widget MainSeat(SeatModel mySeat, int index) {
    bool isBooked = MovieController.listSeatOrder.any((seat) =>
        seat.idSeat == mySeat.id &&
            seat.idDate == widget.dateSelect.id &&
                seat.idTime == widget.timeSelect.id &&
                  seat.idMovie == widget.movieSelect.id


    );

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: isBooked ? null : () => widget.onPressed(mySeat, index, widget.dateSelect, widget.timeSelect), // Chặn sự kiện onTap nếu ghế đã đặt
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.white),
          color: isBooked ? Colors.lightGreen : (widget.selectSeat == index ? Colors.grey : null), // Đổi màu nếu đã đặt
        ),
        child: Center(
          child: Text(
            mySeat.name.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }


}
