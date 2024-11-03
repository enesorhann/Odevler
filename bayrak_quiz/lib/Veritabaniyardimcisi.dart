import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Veritabaniyardimcisi {

  static final String veriTabaniAdi = "bayrakquiz.sqlite";

  Future<Database> veriTabaniErisim() async {
    String veriTabaniYolu = join(await getDatabasesPath(), veriTabaniAdi);

    if (await databaseExists(veriTabaniYolu)) {
      print("VeriTabani zaten var kopyalamaya gerek yok!");
    }

  else{
  var data = await rootBundle.load("veritabani/$veriTabaniAdi");
  List<int> bytes = data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
  await File(veriTabaniYolu).writeAsBytes(bytes,flush: true);
  print("Veri Tabani Kopyalandi!");
  }
  return openDatabase(veriTabaniYolu);
}}