import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:odev_3/views/Page1.dart';
import 'package:odev_3/views/Page2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Color iconColor0;
  late Color iconColor1;
  late Color iconColor2;
  late Color iconColor3;
  late List<Color> colorList;
  @override
  void initState() {
    iconColor0 = Colors.black;
    iconColor1 = Colors.black;
    iconColor2 = Colors.black;
    iconColor3 = Colors.black;
    colorList = [iconColor0,iconColor1,iconColor2,iconColor3];
    super.initState();
  }

  void changeToYellow(){
    setState(() {
      for(int i=0;i<colorList.length;i++){
        colorList[i] = Colors.yellow;
      }
    });
  }
  void changeToBlack(){
    setState(() {
      for(int i=0;i<colorList.length;i++){
        colorList[i] = Colors.black;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("ODEV 3"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
            },
                child: Text("ODEV 1")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Page2()));
            },
                child: Text("ODEV 2")),
          ],
        ),
      )
    );
  }
}
