import 'package:flutter/material.dart';

class Sonucekrani extends StatefulWidget {

  late var dogruSayisi;

  Sonucekrani({required this.dogruSayisi});

  @override
  State<Sonucekrani> createState() => _SonucekraniState();
}

class _SonucekraniState extends State<Sonucekrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Sonuc Ekrani"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.dogruSayisi} Dogru ${5-widget.dogruSayisi} Yanlis",style: TextStyle(fontSize: 30),),
            Text(" % ${widget.dogruSayisi*20}",style: TextStyle(fontSize: 30),),
            SizedBox(
              width: 250,height: 50,
              child: ElevatedButton(
                child: Text("TEKRAR DENE"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
