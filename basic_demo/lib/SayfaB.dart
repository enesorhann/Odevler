import 'package:basic_demo/main.dart';
import 'package:flutter/material.dart';

class SayfaB extends StatefulWidget {
  const SayfaB({super.key});

  @override
  State<SayfaB> createState() => _SayfaBState();
}

class _SayfaBState extends State<SayfaB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.amber,

        title: Text("Sayfa B"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Geldigi Sayfaya Don"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text("Anasayfaya Don"),
              onPressed: (){
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            ElevatedButton(
              child: Text("Anasayfaya Gecis Yap"),
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => Anasayfa()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
