
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {


  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  late List<Color> liste;
  List<String> items =  ["Sari","Kirmizi","Mor","Mavi","Yesil"];
  var color1=Colors.yellow;
  var color2=Colors.red;
  var color3=Colors.deepPurple;
  var color4=Colors.blue;
  var color5=Colors.greenAccent;
  int selectedItem = 0;
  var tfController = TextEditingController();
  List<String> tfTexts =  [];

  @override
  void initState() {
    liste = [color1,color2,color3,color4,color5];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text("Gorev 2"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20,height: 20),
                Expanded(
                  child: TextField(
                      controller: tfController,
                      decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Kelime Girin"
                  )
                  ),
                ),
                SizedBox(width: 30,height: 30),
                Expanded(
                  child: DropdownButton<String>(
                    value: items[selectedItem],
                    items: items
                      .map((item) => DropdownMenuItem<String>(
                    child: Text(item,style: TextStyle(fontSize: 20),),
                    value: item,
                  )
                  ).toList(),
                      onChanged: (item) {selectedItem = items.indexOf(item!);},

                  ),
                ),
                SizedBox(width: 20,height: 20),
              ],
            ),

            ElevatedButton(onPressed: (){
              setState(() {
                tfTexts.add(tfController.text);
                tfController.clear();
                setState(() {
                });
              });

            }, child: Text("Button")),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(

                    height: 400,
                    child: ListView.builder(
                        itemCount: tfTexts.length,
                        itemBuilder: (context,index){
                          return Center(
                            child: Text(tfTexts[index]),
                          );
                        }
                    ),
                  ),
                ),
                Expanded(
                  child: Container(

                    height: 400,
                    child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                    ),
                      itemCount: 8,
                      itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.all(8),
                        color: liste[selectedItem],
                      );
                      },
                    ),
                  ),
                )
              ],
            ),

          ],
        )
    );
  }
}
