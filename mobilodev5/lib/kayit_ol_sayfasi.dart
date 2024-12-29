import 'package:flutter/material.dart';
import 'database_helper.dart'; // DatabaseHelper sınıfını import etmeyi unutmayın!

class KayitOlSayfasi extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  KayitOlSayfasi({super.key});

  Future<void> kayitOl(BuildContext context) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kullanıcı adı ve parola boş olamaz!")),
      );
      return;
    }

    final dbHelper = DatabaseHelper();
    try {
      await dbHelper.insertUser({
        'username': username,
        'password': password,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kayıt başarılı!")),
      );
      Navigator.pushNamed(context, '/giris');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bir hata oluştu: $e")),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Kayıt Ol',style: TextStyle(color: Colors.white),)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Şifre'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                onPressed: () => kayitOl(context),
                child: const Text('Kaydol',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
