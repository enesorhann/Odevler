
void main(){
  String ogrNo = "205";
  String reverseOgrNo = "";
  for(var i=ogrNo.length-1;i>-1;i--){
    reverseOgrNo += ogrNo[i];
  }
  print(reverseOgrNo);
  int sayi = int.parse(reverseOgrNo);

  int enYakinSayi = 0;
  int lower = sayi-1;
  int upper = sayi+1;
  while(lower>1 && !enYakinAsalMi(lower)){
    lower--;
  }
  while(!enYakinAsalMi(upper)){
    upper++;
  }
  if((sayi-lower)<=(upper-sayi)){
    enYakinSayi = lower;
  }else{
    enYakinSayi = upper;
  }
  print("$reverseOgrNo numarasina en yakin asal sayi -> $enYakinSayi");

  asalBul(enYakinSayi); // ODEV1.1 COMPLETED

}

void asalBul(int sayi){
  int i=2;
  while(i<=sayi){
    bool asalMi = true;
    var j=2;
    while(j<=i/2){
      if(i%j == 0){
        asalMi = false;
        break;
      }
      j++;
    }
    if(asalMi){
      print(i);
    }

    i++;
  }
}

bool enYakinAsalMi(int sayi){
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