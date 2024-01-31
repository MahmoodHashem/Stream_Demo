
import 'stream.dart';
import 'package:flutter/material.dart';

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
    changeColor();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          changeColor();
        },
        child: Container(
          color: fcolor,
        ),
      ),
    );
  }
}
