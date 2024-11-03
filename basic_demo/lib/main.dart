import 'package:basic_demo/Kisiler.dart';
import 'package:basic_demo/SayfaA.dart';
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
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {

Future<bool> backButton(BuildContext context) async{
  print("Telefonun Geri Tusuna Tiklandi!");
  return true;
}


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  int sayac = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.tealAccent,

        title: Text("Anasayfa"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: (){
            Navigator.pop(context);
            print("AppBar Uzerindeki Geri Tusuna Basildi!");
          },
        ),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Tıkla"),
              onPressed: (){
                setState(() {
                  sayac += 1;
                });

              },
            ),
            Text(
                "Sonuc: $sayac"
            ),

            ElevatedButton(
              child: Text("Resetle"),
              onPressed: (){
                setState(() {
                  sayac = 0;
                });

              },
            ),
            ElevatedButton(
              child: Text("Sayfa A'ya git"),
              onPressed: (){
                var kisi = Kisiler("Fidlon", 18, 1.60, true);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SayfaA(kisi))
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
