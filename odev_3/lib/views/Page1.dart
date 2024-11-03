import 'dart:math';

import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {


  late List<Color> colorList;
  @override
  void initState() {
    var iconColor0 = Colors.black;
    var iconColor1 = Colors.black;
    var iconColor2 = Colors.black;
    var iconColor3 = Colors.black;
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

  var lambaState = false;






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Gorev 1"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.lightbulb_outlined,size: 50,color: colorList[0],fill: 1,),
              Icon(Icons.lightbulb_outlined,size: 50,color: colorList[1],fill: 1,),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: (){
                  setState(() {
                    // rastgele 2 tanesi yansin
                    var i = Random().nextInt(4);
                    var t = Random().nextInt(4);
                    while(i==t){
                      t = Random().nextInt(4);
                    }

                    colorList[i] = Colors.yellow;
                    colorList[t] = Colors.yellow;

                  });
                },
                onLongPress: (){
                  setState(() {
                    changeToYellow();
                    // hepsi yansin
                    // kapatirken de hepsi sonsun
                  });
                },
                child: ElevatedButton(
                  onPressed: (){
                    if(colorList.contains(Colors.yellow)){
                      changeToBlack();
                    }else{
                      setState(() {
                        var i = Random().nextInt(4);
                        colorList[i] = Colors.yellow;

                      });
                    }

                  },
                  // Tamami kapali iken On,biri bile aciksa Off yaz
                  child:
                  colorList.contains(Colors.yellow) ? Text("TURN LIGHT OFF")
                      :Text("TURN LIGHT ON"),


                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                ),
              )

            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.lightbulb_outlined,size: 50,color: colorList[2],fill: 1,),
              Icon(Icons.lightbulb_outlined,size: 50,color: colorList[3],fill: 1,),
            ],
          ),
        ],
      ),
    );
  }
}
