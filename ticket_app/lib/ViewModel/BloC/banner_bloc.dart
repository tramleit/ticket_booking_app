


import 'dart:async';
import 'dart:developer';

import 'package:ticket_app/Model/banner_model.dart';
import 'package:ticket_app/ViewModel/BloC/base_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/my_event.dart';
import 'package:ticket_app/ViewModel/service.dart';

class BannerBloc extends BaseBloc{

  final ServiceRepository _serviceRepository =
      ServiceRepository();
  final StreamController<List<BannerModel>> _listBannerController =
      StreamController<List<BannerModel>>();

  Stream<List<BannerModel>> get stream => _listBannerController.stream;


  @override
  void dispatchEvent(MyEvent event) {
    if(event is FetchBanner){
      print('Event FetchBanner');
      fetchBanner();
    }
  }
  void fetchBanner() async{
    _serviceRepository.fetchBanner().then((item) {
        _listBannerController.sink.add(item);
    });
  }
  @override
  void dispose() {
    _listBannerController.close();
  }
}