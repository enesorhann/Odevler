import 'package:basic_demo/Kisiler.dart';
import 'package:basic_demo/SayfaB.dart';
import 'package:flutter/material.dart';

class SayfaA extends StatefulWidget {
  Kisiler kisi;

  SayfaA(this.kisi);

  @override
  State<SayfaA> createState() => _SayfaAState();
}

class _SayfaAState extends State<SayfaA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.redAccent,

        title: Text("Sayfa A"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Sayfa B'ye Gecis Yap"),
              onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SayfaB()));
              },
            ),
            Text("Isım: ${widget.kisi.isim}"),
            Text("Yas: ${widget.kisi.yas}"),
            Text("Boy: ${widget.kisi.boy}"),
            Text("Bekar mi: ${widget.kisi.bekarMi}"),
          ],
        ),
      ),
    );
  }
}
