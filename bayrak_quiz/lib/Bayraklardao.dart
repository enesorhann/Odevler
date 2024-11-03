import 'package:bayrak_quiz/Bayraklar.dart';
import 'package:bayrak_quiz/Veritabaniyardimcisi.dart';

class Bayraklardao{
  Future<List<Bayraklar>> bayraklariGetir() async{

    var db = await Veritabaniyardimcisi().veriTabaniErisim();

    List<Map<String,dynamic>> maps =await db.rawQuery("SELECT * FROM bayraklar ORDER BY RANDOM() LIMIT 5");

    return List.generate(maps.length, (i){

      var satir = maps[i];
      return Bayraklar(satir["bayrak_id"], satir["bayrak_ad"], satir["bayrak_resim"]);
    });
  }
  Future<List<Bayraklar>> yanlislariGetir(int bayrak_id) async{

    var db = await Veritabaniyardimcisi().veriTabaniErisim();

    List<Map<String,dynamic>> maps =await db.rawQuery("SELECT * FROM bayraklar WHERE bayrak_id != $bayrak_id ORDER BY RANDOM() LIMIT 3");

    return List.generate(maps.length, (i){

      var satir = maps[i];
      return Bayraklar(satir["bayrak_id"], satir["bayrak_ad"], satir["bayrak_resim"]);
    });
  }
}