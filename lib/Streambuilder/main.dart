
import 'package:flutter/material.dart';
import 'stream2.dart';
import 'dart:async';


void main(){
  runApp(MyApp()); 
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Builder',
      home: HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Stream<int> numberStream;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numberStream = NumberStream().getNumbers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Builder'),
      ),
      body: StreamBuilder(
        stream: numberStream,
          builder: (context, snapshot){
            if(snapshot.hasError){
              print('error');
            }
            if(snapshot.hasData){
              return Center(
                child: Text(snapshot.data.toString()),
              );
            }else{
              return SizedBox();
            }
          }),
    );
  }
}
