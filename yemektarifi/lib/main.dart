import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Yemek Tarifi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.red,

        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
            SizedBox(
                width: ekranGenisligi,
                child: Image.asset("resimler/yemekresim.jpeg")
            ),
             Row(
               children: [
                 Expanded(
                   child: SizedBox(
                     height: ekranYuksekligi/8,
                     child: ElevatedButton(
                       child: Yazi("Begen",ekranGenisligi/20),
                       onPressed: (){
                         print("Begenildi");
                       },
                       style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                         foregroundColor: MaterialStateProperty.all(Colors.white),
                       ),
                     ),
                   ),
                 ),
                 Expanded(
                   child: SizedBox(
                     height: ekranYuksekligi/8,
                     child: ElevatedButton(
                       child: Yazi("Yorum Yap",ekranGenisligi/20),
                       onPressed: (){
                         print("Yorum Yapildi");
                       },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                   
                     ),
                   ),
                 ),
               ],
             ),
              Padding(
                padding: EdgeInsets.all(ekranGenisligi/25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kofte",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: ekranGenisligi/15
        
                      )
                    ),
                    Row(
                      children: [
                        Yazi("Izgara Uzerinde Pisirmeye Uygun", ekranGenisligi/25),
                        Spacer(),
                        Yazi("8 Agustos", ekranGenisligi/25),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(ekranYuksekligi/100),
                child: Yazi("Köfte harcını hazırlamak için, soğanları rendeleyin ve maydanozları ince ince kıyın. İsterseniz, bir diş sarımsak da ekleyebilirsiniz."
                    "Soğan, maydanoz, kıyma, yumurta, zeytinyağı ve tuzu bir kaba alıp iyice yoğurun. Bu sırada istediğiniz baharatları da ekleyerek yoğurmaya devam edin."
                    "Hazırladığınız harcın üzerini streç filmle kapatarak yarım saat buzdolabında dinlendirin."
                    "Ardından harçtan ceviz büyüklüğünde parçalar koparıp yuvarlayın. 1 cm olacak şekilde üzerine bastırarak yassılaştırın.", ekranGenisligi/25),
              )
            ],
        
          ),
      ),
    );
  }
}

class Yazi extends StatelessWidget {
  
  String icerik;
  double yaziBoyutu;


  Yazi(this.icerik, this.yaziBoyutu);

  @override
  Widget build(BuildContext context) {
    return Text(icerik,style: TextStyle(fontSize: yaziBoyutu),);
  }
}

