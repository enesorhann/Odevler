import 'package:dynamic_listview/detaySayfa.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var ulkeler = ["Turkiye","Russia","America","Japan","England","Chinese"];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.deepPurple,

        title: Text("List View"),
      ),
      body: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ulkeler.length,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                print("${ulkeler[index]} satirina tiklandi");
              },
              child: Card(
                child: GestureDetector(
                  onTap: (){
                    print("${ulkeler[index]} tiklandi");
                  },
                  child: SizedBox(
                    width: 191,
                    child: Row(
                      children: [
                        Text("${ulkeler[index]}"),
                        Spacer(),
                        TextButton(
                            child: Text("Ulke Sec",style: TextStyle(color: Colors.red),),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => detaySayfa(ulkeler[index])));
                            }
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Text("Sil",style: TextStyle(color: Colors.deepOrange),),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text("Guncelle",style: TextStyle(color: Colors.deepOrange),),
                            ),
                          ],
                          onSelected: (menuItemValue){
                            if(menuItemValue == 1){
                              print("${ulkeler[index]} silindi");
                            }
                            if(menuItemValue == 2){
                              print("${ulkeler[index]} guncellendi");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
