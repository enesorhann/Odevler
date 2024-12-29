import 'package:flutter/material.dart';
import 'database_helper.dart';

class GirisYapSayfasi extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  GirisYapSayfasi({super.key});

  Future<void> girisYap(BuildContext context) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen kullanıcı adı ve parolayı girin!")),
      );
      return;
    }

    try {
      final dbHelper = DatabaseHelper();
      final user = await dbHelper.getUserByUsernameAndPassword(username, password);
      if (user != null) {
        Navigator.pushNamed(
          context,
          '/bilgilerim',
          arguments: user['id'], // user['id'] doğru bir şekilde gönderiliyor
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Kullanıcı adı veya parola hatalı!")),
        );
      }
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
          title: const Text('Giriş Yap',style: TextStyle(color: Colors.white),)
      ),
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
                decoration: const InputDecoration(labelText: 'Parola'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                onPressed: () => girisYap(context),
                child: const Text('Giriş Yap',style: TextStyle(color: Colors.white),),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/kayit'),
                child: const Text('Hesabınız yok mu? Kayıt Olun',style: TextStyle(color: Colors.blueAccent),),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () => Navigator.pushNamed(context, '/kullanicilar'),
        child: const Icon(Icons.people,color: Colors.white,),
      ),
    );
  }
}
