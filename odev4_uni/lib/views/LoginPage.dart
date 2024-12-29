import 'package:flutter/material.dart';
import 'package:odev4_uni/views/TanitimPage.dart';


class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  var formKey = GlobalKey<FormState>();
  var kullaniciAdi = "Enes";
  var sifre = "enes.0101";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("Login",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,),),
      ),
      body: Form(
        key: formKey,
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Kullanici Adi"
                ),
                validator: (gelenText){
                  if(gelenText!=null){
                    if(gelenText.isEmpty){
                      return "Kullanici Adinizi giriniz!";
                    }
                    if(gelenText != kullaniciAdi){
                      return "Kullanici Adi Hatali";
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Sifre"
                ),
                validator: (gelenText){
                  if(gelenText!=null){
                    if(gelenText.isEmpty){
                      return "Sifrenizi giriniz!";
                    }
                    if(gelenText != sifre){
                      return "Sifre Hatali";
                    }
                  }
                  return null;
                },

              ),
              ElevatedButton(
                  onPressed: (){
                    bool kontrolSonucu = formKey.currentState!.validate();
                    if(kontrolSonucu){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> TanitimPage()));
                    }

                  },
                  child: Text("Tanitim Sayfasina Git"),
              ),
            ],
          ),
        ),
      ))
    );
  }
}
