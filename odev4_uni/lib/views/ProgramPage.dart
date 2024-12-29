import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProgramPage extends StatefulWidget {
  @override
  State<ProgramPage> createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  var kelimeListesi = <String>[];
  var aramaSonuclari = <String>[];
  var tfController = TextEditingController();
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _dosyayiOku();
  }

  Future<void> _dosyayiOku() async {
    try {
      var text = await rootBundle.loadString("texts/texts.txt");
      var kelimeler = text.split(RegExp(r'\s+'));
      setState(() {
        kelimeListesi = kelimeler;
      });
    } catch (e) {
      print("Dosya okunurken hata: $e");
    }
  }

  void kelimeBul(String harfler) {
    if (harfler.isEmpty) {
      setState(() {
        aramaSonuclari = [];
      });
      return;
    }

    List girilenHarfler = harfler.replaceAll(' ', '').split(',');
    var girilenHarfMap = <String, int>{};
    for (var harf in girilenHarfler) {
      //mesela a,b,ç,a girdisini sırayla okuruz a icin once 1 sonrasında ustune ekler
      girilenHarfMap[harf] = (girilenHarfMap[harf] ?? 0) + 1;
    }

    setState(() {
      // Set veri yapisini kullandim
      // cunku bu yapıda aynı eleman birden fazla kez bulunamaz
      var bulunanKelimeler = <String>{};
      aramaSonuclari = [];

      for (var satir in kelimeListesi) {
        List yeniKelimeler = satir.split(RegExp(r'\s+'));
        String birlesikKelime = yeniKelimeler.join('');

        if (birlesikKelime.length == 1) {
          continue;
        }

        bool tumKelimeUygunMu = true;
        var kullanilanHarfler = <String, int>{};
        bool gecerliMi = true;

        for (var harf in birlesikKelime.split('')) {
          if (!girilenHarfMap.containsKey(harf)) {
            gecerliMi = false;
            break;
          }
          /*
            burada da kısaca girdideki harflerin bu kelimede toplamda
                      kac tane icerdigini aliyoruz
            */
          kullanilanHarfler[harf] = (kullanilanHarfler[harf] ?? 0) + 1;

          if (kullanilanHarfler[harf]! > girilenHarfMap[harf]!) {
            gecerliMi = false;
            break;
          }}

        if (!gecerliMi) {
          tumKelimeUygunMu = false; }
        
        if (tumKelimeUygunMu) {
          bulunanKelimeler.add(satir);
          // set veri yapısı indexlenmedigi icin hata veriyordu
          // listeye çevirdim
          aramaSonuclari = bulunanKelimeler.toList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          "Program",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              focusNode: focusNode,
              controller: tfController,
              decoration: InputDecoration(
                labelText: "Harfleri girin (örnek: a,b,ç)",
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                kelimeBul(tfController.text.replaceAll(' ', ''));
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Text("Ara"),
            ),
            Expanded(
              child: aramaSonuclari.isNotEmpty
                  ? ListView.builder(
                      itemCount: aramaSonuclari.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(aramaSonuclari[index]),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text("Sonuç bulunamadı."),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
