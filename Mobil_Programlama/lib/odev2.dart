import 'dart:collection';
import 'dart:math';

void main(){
  var zar1;
  var zar2;
  int kacGun=0;
  var bilgiler = HashMap<String,String>();
  var aylar = <String>[
    'Ocak',
    'Şubat',
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Agustos",
    "Eylul",
    "Ekim",
    "Kasim",
    "Aralik"
  ];
  var sayac = 365;
  int gun;
  int toplam;
  bool sonuc;
  var ayIndex ;
  var gunIndex ;

  for(gun=1;gun<=sayac;gun++){
    zar1 = Random().nextInt(6)+1;
    zar2 = Random().nextInt(6)+1;
    toplam = zar2+zar1;

    sonuc = asalBul(toplam);
    if(sonuc){
      if(gun<30){
        gunIndex = gun;
        ayIndex = 1;
      }else{
        gunIndex = gun % 30 == 0 ? 30 : gun % 30;
        ayIndex = (gun/30).toInt();
      }

      String ay = aylar[ayIndex-1];
      if(bilgiler.containsKey(ay)){
        bilgiler[ay] = "${gunIndex},${bilgiler[ay]}";
        //print(gunIndex);
      }else{
        bilgiler[ay] = gunIndex.toString();
      }
      kacGun++;
    }
  }
  print("Oyun oynayabilecegi tarihler -> ${bilgiler} ");
  print("Oyun oynayabilecegi gun sayisi -> $kacGun ");

}

bool asalBul(int sayi){
  if(sayi<2){
    return false;
  }
  int i;
  bool asalMi=true;

  for(i=2;i<sayi;i++){
    if(sayi%i == 0){
      asalMi = false;
    }
  }
  if(asalMi){
    return true;
  }else{
    return false;
  }
}