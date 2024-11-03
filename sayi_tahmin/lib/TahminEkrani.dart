import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sayi_tahmin/SonucEkrani.dart';

class Tahminekrani extends StatefulWidget {

  @override
  State<Tahminekrani> createState() => _TahminekraniState();
}

class _TahminekraniState extends State<Tahminekrani> {


  var tfTahmin = TextEditingController();
  int kalanHak = 5;
  String yonlendirme = "";
  late int rastgeleSayi;

  @override
  void initState() {
    super.initState();
    rastgeleSayi = Random().nextInt(101);
    print("Rastegele Sayi : $rastgeleSayi");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Tahmin Ekrani"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Kalan Hakkiniz $kalanHak",style: TextStyle(color: Colors.pink,fontSize: 36,fontWeight: FontWeight.bold),),
            Text("Yardim: $yonlendirme",style: TextStyle(color: Colors.black54,fontSize: 30,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tfTahmin,
                decoration: InputDecoration(
                  labelText: "Tahmin",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                child: Text("Tahmin Et"),

                onPressed: (){

                  setState(() {
                    kalanHak--;
                  });
                  int tahmin = int.parse(tfTahmin.text);

                  if(tahmin == rastgeleSayi){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sonucekrani(sonuc: true,) ));
                    return;
                  }
                  if(tahmin > rastgeleSayi){
                    setState(() {
                      yonlendirme = "Tahmini Azaltin";
                    });
                  }
                  if(tahmin < rastgeleSayi){
                    setState(() {
                      yonlendirme = "Tahmini Arttirin";
                    });
                  }
                  if(kalanHak==0){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sonucekrani(sonuc: false,) ));
                  }
                  tfTahmin.text = "";
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
