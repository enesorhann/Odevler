import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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


  var liste = <String>[];
  var secilenUlke = "Italy";

  @override
  void initState() {
    super.initState();
    liste.add("Turkey");
    liste.add("Germany");
    liste.add("England");
    liste.add("France");
    liste.add("Italy");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (canPopState) => print("Geri tusu tiklandi"),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                  value: secilenUlke,
                  items: liste.map<DropdownMenuItem<String>>((String e){
                    return DropdownMenuItem(
                        value: e,
                        child: Text("Ulke : $e",style: TextStyle(color: Colors.greenAccent,fontSize: 25),)
                    );
                  }).toList(),
                  onChanged: (String? data){
                    setState(() {
                      secilenUlke = data!;
                    });
                  },
                icon: Icon(Icons.arrow_drop_down),
                dropdownColor: Colors.green,
                focusColor: Colors.redAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
