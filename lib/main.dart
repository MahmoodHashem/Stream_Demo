
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
  
  late StreamSubscription subscription;

  late StreamTransformer<int, int> transformer;

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

  void addNumber(){
    Random random = Random();
    int myNum = random.nextInt(10);

    if(!controller.isClosed){
    numberStream.addToSink(myNum);
    }else{
      setState(() {
        lastNumber = -1;
      });
    }
  }

  void stopStream(){
    controller.close();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    numberStream = NumberStream();
    controller = numberStream.streamController;

    transformer = StreamTransformer<int, int>.fromHandlers(
      handleData: (data, sink) {
        sink.add(data * 10);
      },
      handleError: (error, stackTrace, sink) {
        sink.addError(-1);
      },
      handleDone: (sink) {
        sink.close();
      },
    );

    Stream stream = controller.stream;

    subscription =  stream.listen((numberEvent) {
      setState(() {
        lastNumber = numberEvent;
      });
    });
    subscription.onError((error){
      setState(() {
        lastNumber = -1;
      });
    });

    subscription.onDone(() {
      print("On done was called");
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.close();
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
              ElevatedButton(onPressed: addNumber, child: const Text("Add A new Number")),
              ElevatedButton(onPressed: (){
                stopStream();
              }, child: const Text("Stop Subscription"))
            ],
          ),
        ),
      ),
    );
  }
}
