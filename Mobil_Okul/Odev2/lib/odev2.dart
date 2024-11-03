import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class odev2 extends StatefulWidget {
   odev2({super.key});

  @override
  State<odev2> createState() => _odev2State();
}

class _odev2State extends State<odev2> {

  var controllerText = TextEditingController();
  double fontSize = 15.0; // Başlangıç font boyutu
  String fontStyle = 'Georgia';
  List<String> fontListesi = [
    'Roboto',
    'Arial',
    'Times New Roman',
    'Courier',
    'Georgia',
    'Verdana',
  ];

  void rastgeleFont(){
    var random = Random().nextInt(fontListesi.length);
    setState(() {
      fontStyle = fontListesi[random];
    });
  }
  void fontArttir(){
    setState(() {
      fontSize +=1;
    });
  }
  void fontAzalt(){
    setState(() {
      fontSize -=1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.deepPurple,

        title: Text("Mobil Programlama Odev2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enes Orhan",style: TextStyle(fontSize: fontSize,fontFamily: fontStyle)),

            ElevatedButton(onPressed: fontArttir,
                child: Text("Font arttır")
            ),

            ElevatedButton(onPressed: fontAzalt,
                child: Text("Font azalt")
            ),

            ElevatedButton(onPressed: rastgeleFont,
                child: Text("Rastgele Font")
            ),

          ],
        )
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
