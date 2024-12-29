import 'package:flutter/material.dart';
import 'package:odev6/data/Services/Services.dart';
import 'package:odev6/data/entities/Harcamalar.dart';
import 'package:odev6/data/entities/Users.dart';
import 'package:odev6/views/Pages/HesaplamaDetay.dart';

class Hesaplama extends StatefulWidget {
  int userID;

  Hesaplama(this.userID);

  @override
  State<Hesaplama> createState() => _HesaplamaState();
}

class _HesaplamaState extends State<Hesaplama> {

  Future<List<Harcamalar>> tumHarcamalar() async {
    var harcamalarListesi = <Harcamalar>[];
    harcamalarListesi = await Services().getGelirGiderByUserID(widget.userID);
    return harcamalarListesi;
  }

  @override
  void initState() {
    super.initState();
    tumHarcamalar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Harcamalar>>(
          future: tumHarcamalar(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var harcamaListesi = snapshot.data;
              return ListView.builder(
                itemCount: harcamaListesi!.length,
                itemBuilder: (context, index) {
                  var harcama = harcamaListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HesaplamaDetay(harcama)));
                    },
                    child: Card(
                      elevation: 5.0,
                      surfaceTintColor: Colors.black,
                      color: Colors.lightBlueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tarih: ${harcama.tarih}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "${harcama.gelirAciklama}:  ₺ +${harcama.gelir}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  maxLines: 5,
                                  "${harcama.giderAciklama}:  ₺ -${harcama.gider}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () async {
                                await Services()
                                    .deleteGelirGider(harcama.harcamaID);
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 40,
                              ),
                            ),
                          ],

                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Veri Bulunamadi"),
              );
            }
          },
        ));
  }
}
