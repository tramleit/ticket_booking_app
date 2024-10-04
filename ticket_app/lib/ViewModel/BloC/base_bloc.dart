
import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'my_event.dart';

abstract class BaseBloc{
  final StreamController<MyEvent> _eventController =
  StreamController<MyEvent>();

  Sink<MyEvent> get event => _eventController.sink;

  BaseBloc(){
    _eventController.stream.listen((event) {
      dispatchEvent(event);
    });
  }
  void dispatchEvent(MyEvent event);

  @mustCallSuper
  void dispose(){
    _eventController.close();
  }
}