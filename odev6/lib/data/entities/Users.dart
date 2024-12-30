import 'dart:io';

import 'package:odev6/data/entities/Harcamalar.dart';

class Users {
  late int userID;
  late String userName;
  late String password;
  File? imageFile;

  Users(
      {required this.userID,
      required this.userName,
      required this.password,
      required this.imageFile,
      });
}
