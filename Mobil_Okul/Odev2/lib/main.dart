import 'package:flutter/material.dart';
import 'package:odev2/odev1.dart';
import 'package:odev2/odev2.dart';

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
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mobil Odev 2'),
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
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           ElevatedButton(onPressed: (){
           Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => odev1()),
           );
           }, child: Text("Odev 1")),
            ElevatedButton(onPressed: (){

              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => odev2()));
            }, child: Text("Odev 2"))
          ],
        ),
      ),
    );
  }
}
