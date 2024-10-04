

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ticket_app/Model/movie_model.dart';

import '../../CheckOutPage/checkout_page.dart';

class MyDescription extends StatefulWidget {
  final MovieModel myMovie;
  const MyDescription({super.key, required this.myMovie});

  @override
  State<MyDescription> createState() => _MyDescriptionState();
}

class _MyDescriptionState extends State<MyDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Container(
         // margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 210,
        //  color: Colors.red,
          child: Text(
            widget.myMovie!.description.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: CupertinoColors.systemGrey3,
              overflow: TextOverflow.ellipsis
            ),
            maxLines: 8,
          ),

        ),
        const SizedBox(height: 10,),
        Container(
          child: ElevatedButton(

            onPressed: (){
              Get.to(()=> const MainCheckOutPage(),
                duration: Duration(milliseconds: 300),
                arguments: widget.myMovie,
                transition: Transition.fade,

              );
            },

            style: ElevatedButton.styleFrom(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              elevation: 0,
                minimumSize: const Size(350, 45),
              backgroundColor: const Color(0xFF8A6ADE)

            ),
            child: const Row(
              children: [
                Icon(Icons.airplane_ticket_outlined, color:  Colors.white, size: 17,),
                SizedBox(width: 7,),
                Text(
                  'Buy Ticket',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.white
                  ),
                ),
                
              ],
            ),
          ),
        )
      ],
    );
  }
}
