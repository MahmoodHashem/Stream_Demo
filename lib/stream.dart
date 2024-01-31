
import 'package:flutter/material.dart';
import 'dart:async';

class ColorStream{

  final _colors =[
    Colors.pink,
    Colors.blueGrey,
    Colors.greenAccent,
    Colors.tealAccent,
    Colors.orange,
  ];


  Stream<Color> getColors () async*{
    yield* Stream.periodic(const Duration( seconds: 1), (int t) {
      int index = t % _colors.length;
      return _colors[index];
    },);


  }

}


class NumberStream{

  final StreamController<int> streamController = StreamController<int>();

  void addToSink(int number){
    streamController.sink.add(number);
  }

  close(){
    streamController.close(); 
  }

}