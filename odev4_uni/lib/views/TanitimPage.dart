import 'package:flutter/material.dart';
import 'package:odev4_uni/views/ProgramPage.dart';


class TanitimPage extends StatefulWidget {

  @override
  State<TanitimPage> createState() => _TanitimPageState();
}

class _TanitimPageState extends State<TanitimPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text("Tanitim",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,),),
        ),
        body: Form(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Kelime Bulucu",style: TextStyle(fontSize: 50,color: Colors.black,fontWeight: FontWeight.bold,),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Baslamak Icin Tiklayiniz",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,),),
                      SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProgramPage()));
                        },
                        child: Text("Programa Gir"),
                      ),
                    ],
                  )
                ],
              ),
            ))
    );
  }
}
