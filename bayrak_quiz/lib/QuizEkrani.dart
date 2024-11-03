import 'dart:collection';
import 'package:bayrak_quiz/SonucEkrani.dart';
import 'package:flutter/material.dart';
import 'Bayraklar.dart';
import 'Bayraklardao.dart';

class Quizekrani extends StatefulWidget {
  const Quizekrani({super.key});

  @override
  State<Quizekrani> createState() => _QuizekraniState();
}

class _QuizekraniState extends State<Quizekrani> {

  var sorular = <Bayraklar>[];
  var yanlisSorular = <Bayraklar>[];
  late Bayraklar dogruSoru;
  var tumSecenekler = HashSet<Bayraklar>();

  int soruSayac = 0;
  int dogruSayac = 0;
  int yanlisSayac = 0;

  var bayrakResimAdi = "placeholder.png";
  var buttonA_yazi = "";
  var buttonB_yazi = "";
  var buttonC_yazi = "";
  var buttonD_yazi = "";

  @override
  void initState() {
    super.initState();
    sorulariAl();
  }
  Future<void> sorulariAl() async{
    sorular = await Bayraklardao().bayraklariGetir();
    arayuzeSoruYukle();
  }
  Future<void> arayuzeSoruYukle() async{
    dogruSoru = sorular[soruSayac];
    bayrakResimAdi = dogruSoru.bayrak_resim;
    yanlisSorular = await Bayraklardao().yanlislariGetir(dogruSoru.bayrak_id);

    tumSecenekler.clear();
    tumSecenekler.add(dogruSoru);
    tumSecenekler.add(yanlisSorular[0]);
    tumSecenekler.add(yanlisSorular[1]);
    tumSecenekler.add(yanlisSorular[2]);

    buttonA_yazi = tumSecenekler.elementAt(0).bayrak_ad;
    buttonB_yazi = tumSecenekler.elementAt(1).bayrak_ad;
    buttonC_yazi = tumSecenekler.elementAt(2).bayrak_ad;
    buttonD_yazi = tumSecenekler.elementAt(3).bayrak_ad;

    setState(() {
    });
  }

  void soruSayacKontrol(){
    soruSayac++;

    if(soruSayac!=5){
      arayuzeSoruYukle();
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sonucekrani(dogruSayisi: dogruSayac)));
    }
  }

  void dogruKontrol(var buttonYazi){
    if(dogruSoru.bayrak_ad == buttonYazi){
      dogruSayac++;
    } else{
      yanlisSayac++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Quiz Ekrani"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Dogru: $dogruSayac",style: TextStyle(fontSize: 18),),
                Text("Yanlis: $yanlisSayac",style: TextStyle(fontSize: 18),),
              ],
            ),
            soruSayac != 5 ? Text("$soruSayac. Soru",style: TextStyle(fontSize: 30),) :
            Text("5. Soru",style: TextStyle(fontSize: 30),),
            Image.asset("resimler/$bayrakResimAdi"),
            SizedBox(
              width: 250,height: 50,
              child: ElevatedButton(
                child: Text(buttonA_yazi),
                onPressed: (){
                  dogruKontrol(buttonA_yazi);
                  soruSayacKontrol();
                },
              ),
            ),
            SizedBox(
              width: 250,height: 50,
              child: ElevatedButton(
                child: Text(buttonB_yazi),
                onPressed: (){
                  dogruKontrol(buttonB_yazi);
                  soruSayacKontrol();
                },
              ),
            ),
            SizedBox(
              width: 250,height: 50,
              child: ElevatedButton(
                child: Text(buttonC_yazi),
                onPressed: (){
                  dogruKontrol(buttonC_yazi);
                  soruSayacKontrol();
                },
              ),
            ),
            SizedBox(
              width: 250,height: 50,
              child: ElevatedButton(
                child: Text(buttonD_yazi),
                onPressed: (){
                  dogruKontrol(buttonD_yazi);
                  soruSayacKontrol();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
