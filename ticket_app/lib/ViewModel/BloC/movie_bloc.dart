
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/Model/response_model.dart';
import 'package:ticket_app/ViewModel/BloC/movie_controller.dart';
import 'package:ticket_app/ViewModel/service.dart';
import 'package:ticket_app/ViewModel/utill.dart';

import 'base_bloc.dart';
import 'my_event.dart';

class MovieBloc extends BaseBloc{
  final MovieController _movieController =
      MovieController();
  final ServiceRepository _serviceRepository =
    ServiceRepository();

  final StreamController<List<MovieModel>> _moviesListSteamController =
      StreamController<List<MovieModel>>();

  Stream<List<MovieModel>> get streamMovies => _moviesListSteamController.stream;
  List<MovieModel> dataMovies = [];

  @override
  void dispatchEvent(MyEvent events) async{
    if(events is FetchMovies){
      print('Event Fetch Moviessssss');
      fetchMovie();
      _movieController.loadMovieController();
    }
    if(events is OrderSeat){
      print('Event Order Seat');
      insertOrder(events.data as Object, events.context);
    }

    if(events is AddMovie){
      print('Event Add Movie');
      insertMovie(events.data as Object, events.imageAssets, events.imageBanner ,events.context);
    }

    if(events is DeleteMovie){
      print('Delete Movie');
      deleteMovie(events.context, events.id);
    }

    if(events is EditMovie){
      print('Edit Movie 2');
      editMovie2(events.data as Object,events.context, events.imageAsset, events.imageBanner);

    }
  }
  editMovie2(Object data ,BuildContext context, String path1, String path2) async{
    ResponseModel res = await _serviceRepository.editMovie(data, path1, path2);
    if(res != null){
      Utill.showSimpleDialog(context, res.message.toString());
    }
    else{
      Utill.showSimpleDialog(context, "Có lỗi xảy ra");
    }
  }

  insertMovie(Object data, File imageAsset, File imageBanner, BuildContext context) async{
    ResponseModel res = await _serviceRepository.addMovie(data, imageAsset, imageBanner);
    if(res != null){
      Utill.showSimpleDialog(context, res.message.toString());
    }
    else{
      Utill.showSimpleDialog(context, "Có lỗi xảy ra");
    }
  }
  insertOrder(Object data, BuildContext context) async{
    ResponseModel result = await _serviceRepository.orderSeat(data);
    if(result != null){
        Utill.showSimpleDialog(context, result.message.toString());
    }else{
      Utill.showSimpleDialog(context, "Có lỗi xảy ra");
    }
  }
  fetchMovie() async{
    _serviceRepository.fetchMovies().then((item){
      print(item);
      _moviesListSteamController.sink.add(item);
    });
  }

  deleteMovie(BuildContext context, String id) async{
    ResponseModel res = await _serviceRepository.deleteMovie(id);
    if(res != null){
      Utill.showSimpleDialog(context, res.message.toString());
    }else{
      Utill.showSimpleDialog(context, "Có lỗi xảy ra");
    }
  }
  @override
  void dispose() {
    _moviesListSteamController.close();
  }
}