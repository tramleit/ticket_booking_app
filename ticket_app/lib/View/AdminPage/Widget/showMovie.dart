

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/View/AdminPage/Widget/edit_movie.dart';
import 'package:ticket_app/ViewModel/BloC/movie_bloc.dart';
import 'package:ticket_app/ViewModel/service.dart';

import '../../../ViewModel/BloC/my_event.dart';
import 'add_movie.dart';

class ShowMovie extends StatefulWidget {
  const ShowMovie({super.key});


  @override
  State<ShowMovie> createState() => _ShowMovieState();
}

class _ShowMovieState extends State<ShowMovie> {
  late MovieBloc bloc;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bloc = Provider.of<MovieBloc>(context);
    bloc.event.add(FetchMovies());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Consumer<MovieBloc>(
        builder: (context, bloc, child){
          return StreamBuilder(
            stream: bloc.streamMovies,
            builder: (context, snapshot){
              if(!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty){
                return Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              switch(snapshot.connectionState){
                case ConnectionState.active:
                  return ListView.builder(

                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return myMovie(snapshot.data![index]);
                    }
                  );
                default:
                  return Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: const CircularProgressIndicator(),
                    ),
                  );
              }

            }
          );
        }
      )
    );
  }

  Widget myMovie(MovieModel movie){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2534), // Màu nền
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage('${ServiceRepository.baseURL}${movie.imageasset}'),
                    fit: BoxFit.cover
                )
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      movie.title.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Text(
                    'Acter: ${movie.title.toString()}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey4,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      overflow: TextOverflow.ellipsis,

                    ),
                    maxLines: 1,
                  ),
                   Text(
                    'Description: ${movie.description.toString()}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey4,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      overflow: TextOverflow.ellipsis,

                    ),
                    maxLines: 1,
                  ),
                  Container(
                    width: 120,
                    height: 10,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index){
                          if(index < movie.favourite!.toInt()){
                            return const Icon(Icons.star, size: 20, color: Colors.yellow,);
                          }
                          return const Icon(Icons.star, size: 20, color: Colors.white24,);
                        }
                    ),
                  )

                ],

              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: InkWell(
                        onTap: (){

                        },
                        child: const Icon(Icons.add, color: Colors.white,)
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent[400],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: InkWell(
                        onTap: (){
                            Get.to(() =>
                                const EditMoviePage(),
                                duration: const Duration(milliseconds: 300),
                                transition: Transition.fadeIn,
                                arguments: {
                                  'movie': movie,
                                  'bloc': bloc,
                                },
                            );
                        },
                        child: const Icon(Icons.edit, color: Colors.white,)
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: InkWell(
                        onTap: (){
                          print('idMovie: '  + movie.title.toString() + ", " + movie.id.toString());
                          bloc.event.add(DeleteMovie(context: context, id: movie.id.toString()));
                          bloc.event.add(FetchMovies());
                        },
                        child: const Icon(Icons.delete, color: Colors.white,)
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
