import 'package:flutter/material.dart';
import 'package:mobilodev5/bilgilerim_sayfasi.dart';
import 'package:mobilodev5/kayit_ol_sayfasi.dart';
import 'package:mobilodev5/kullanicilar_sayfasi.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'giris_yap_sayfasi.dart';

void main() {
  runApp(const MyApp());

  Future<void> printDatabasePath() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    print('Database Path: $path');
  }

  printDatabasePath(); // Veritabanı yolunu yazdırmak için çağırılıyor
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobil Programlama Ödev 5',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GirisYapSayfasi(),
      // onGenerateRoute işleviyle dinamik rotalar işleniyor
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/bilgilerim':
            final userId = settings.arguments as int; // Argument olarak gönderilen userId alınır
            return MaterialPageRoute(
              builder: (context) => BilgilerimSayfasi(userId: userId),
            );
          case '/kayit':
            return MaterialPageRoute(
              builder: (context) => KayitOlSayfasi(),
            );
          case '/kullanicilar':
            return MaterialPageRoute(
              builder: (context) => KullanicilarSayfasi(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => GirisYapSayfasi(), // Hatalı bir rota için varsayılan sayfa
            );
        }
      },
    );
  }
}
