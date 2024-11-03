import 'package:flutter/material.dart';

class Sonucekrani extends StatefulWidget {

  late bool sonuc;


  Sonucekrani({required this.sonuc});

  @override
  State<Sonucekrani> createState() => _SonucekraniState();
}

class _SonucekraniState extends State<Sonucekrani> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Sonuc Ekrani"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

           widget.sonuc ? Image.asset("resimler/mutlu_resim.png") : Image.asset("resimler/uzgun_resim.png"),
            Text( (widget.sonuc ? "Kazandiniz" : "Kaybettiniz"),
              style: TextStyle(color: Colors.black54,fontSize: 36,fontWeight: FontWeight.bold),
            ),

            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                child: Text("Tekrar Dene"),

                onPressed: (){
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
