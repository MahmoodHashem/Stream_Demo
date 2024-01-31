
import 'stream.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Demo',
      home: StreamHomePage(),
    );
  }
}




class StreamHomePage extends StatefulWidget {
  const StreamHomePage({Key? key}) : super(key: key);

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {

  Color fcolor = Colors.blue;
  late ColorStream colorStream;

  int lastNumber = 0;
  late StreamController controller;
  late NumberStream numberStream;

  void changeColor() async {
    colorStream = ColorStream();

    // await for(var eventColor in colorStream.getColors()){
    // setState(() {
    //      fcolor = eventColor;
    // }); }

    colorStream.getColors().listen((eventColor) {
      setState(() {
        fcolor = eventColor;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    numberStream = NumberStream();
    controller = numberStream.streamController;

    Stream stream = controller.stream;

    stream.listen((numberEvent) {
      setState(() {
        lastNumber = numberEvent;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.close();
  }


  void addNumber(){
    Random random = Random();

    int myNum = random.nextInt(10);
    numberStream.addToSink(myNum);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          changeColor();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(lastNumber.toString()),
              ElevatedButton(onPressed: addNumber, child: Text("Add A new Number"))
            ],
          ),
        ),
      ),
    );
  }
}
