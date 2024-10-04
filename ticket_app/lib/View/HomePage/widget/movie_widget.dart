
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/View/DetailPage/detail_page.dart';
import 'package:ticket_app/ViewModel/service.dart';

import '../../../Model/movie_model.dart';
import '../../../ViewModel/BloC/movie_bloc.dart';
import '../../../ViewModel/BloC/my_event.dart';

class MovieWidget extends StatefulWidget {


  const MovieWidget({super.key});
  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: implement didChangeDependencies
    var bloc = Provider.of<MovieBloc>(context);
    bloc.event.add(FetchMovies());

  }


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 13, left: 10,top: 10),
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Movie",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
               InkWell(
                 onTap: (){},
                 child: const Text(
                  "View all",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.yellow
                  ),
                               ),
               ),
            ],
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          height: 290,
         // color: Colors.red,
          child: Consumer<MovieBloc>(
            builder: (context, bloc, child) => StreamBuilder(
              stream: bloc.streamMovies,
              builder: (context, snapshot) {
                if(!snapshot.hasData || snapshot.data!.isEmpty){
                  return const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                switch(snapshot.connectionState){
                  case ConnectionState.active:
                    return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index){
                              return InkWell(
                              onTap: () {
                              Get.to(() => const MyDetailPage(),
                              transition: Transition.fade ,
                              duration: Duration(milliseconds: 300),
                              arguments: snapshot.data![index]
                              );
                              //print(listMovie[index].title.toString());
                              },
                              child: mainMovie(snapshot.data![index]),
                              );
                          }
                    );
                  case ConnectionState.waiting:
                    return Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  default:
                    return Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: const Text("Data not found"),
                      ),
                    );
                }

              }
            ),
          ),
        )
      ],
    );
  }
  Widget mainMovie(MovieModel movie){
    //print('${movie.title} - ${movie.favourite}');
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          //fit: StackFit.expand,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, top: 7, right: 3),
              width: 150,
              height: 220,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage('${ServiceRepository.baseURL}${movie.imageasset}'),
                      fit: BoxFit.cover
                  )
              ),
            ),

          ]
        ),
        Container(
          padding: EdgeInsets.only(left: 5,top: 5),
          width: 150,
         // color: Colors.green,
          child: Text(
              movie.title.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
                color: Colors.white
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 5),
          width: 150,
          height: 15,
        //  color: Colors.green,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index){
                if(index < movie.favourite!.toInt()){
                  return const Icon(Icons.star, color: Colors.yellow, size: 15,);
                }
                return const Icon(Icons.star, size: 15,color: Colors.white24,);
              }
          )
        ),
      ],
      
      
    );
  }

}
