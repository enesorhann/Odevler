import 'package:flutter/material.dart';
import 'database_helper.dart';

class BilgilerimSayfasi extends StatefulWidget {
  final int userId; // Kullanıcı ID'si

  const BilgilerimSayfasi({required this.userId, super.key});

  @override
  _BilgilerimSayfasiState createState() => _BilgilerimSayfasiState();
}

class _BilgilerimSayfasiState extends State<BilgilerimSayfasi> {
  final TextEditingController _adSoyadController = TextEditingController();
  final TextEditingController _dogumTarihiController = TextEditingController();

  String _cinsiyet = "Erkek";
  List<String> _hobiler = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await DatabaseHelper().getUserInfoByUserId(widget.userId);

      if (userInfo != null) {
        setState(() {
          _adSoyadController.text = userInfo['full_name'] ?? '';
          _dogumTarihiController.text = userInfo['birth_date'] ?? '';
          _cinsiyet = userInfo['gender'] ?? 'Erkek';
          _hobiler = (userInfo['hobbies'] as String?)?.split(',') ?? [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bilgiler yüklenirken hata oluştu: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> kaydet(BuildContext context) async {
    String adSoyad = _adSoyadController.text.trim();
    String dogumTarihi = _dogumTarihiController.text.trim();

    if (adSoyad.isEmpty || dogumTarihi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm bilgileri doldurun!")),
      );
      return;
    }

    final userInfo = {
      'full_name': adSoyad,
      'birth_date': dogumTarihi,
      'gender': _cinsiyet,
      'hobbies': _hobiler.join(','), // Hobiler virgülle ayrılarak saklanıyor
      'user_id': widget.userId, // Kullanıcı ID'siyle ilişkilendiriliyor
    };

    try {
      await DatabaseHelper().insertOrUpdateUserInfo(userInfo); // Güncelleme veya ekleme yapılır
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bilgiler kaydedildi!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt sırasında hata oluştu: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Bilgilerim')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _adSoyadController,
                      decoration: const InputDecoration(labelText: 'Ad ve Soyad'),
                    ),
                    const SizedBox(height: 10),
                    const Text('Cinsiyet:'),
                    Row(
                      children: [
                        Radio(
                          focusColor: Colors.deepOrange,
                          hoverColor: Colors.deepOrange,
                          activeColor: Colors.deepOrange,
                          value: "Erkek",
                          groupValue: _cinsiyet,
                          onChanged: (value) {
                            setState(() {
                              _cinsiyet = value!;
                            });
                          },
                        ),
                        const Text('Erkek'),
                        Radio(
                          focusColor: Colors.deepOrange,
                          hoverColor: Colors.deepOrange,
                          activeColor: Colors.deepOrange,
                          value: "Kadın",
                          groupValue: _cinsiyet,
                          onChanged: (value) {
                            setState(() {
                              _cinsiyet = value!;
                            });
                          },
                        ),
                        const Text('Kadın'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _dogumTarihiController,
                      decoration: const InputDecoration(
                        labelText: 'Doğum Tarihi',
                        hintText: 'GG/AA/YYYY',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Hobiler:'),
                    CheckboxListTile(
                      hoverColor: Colors.deepOrange,
                      activeColor: Colors.deepOrange,
                      title: const Text('Spor'),
                      value: _hobiler.contains('Spor'),
                      onChanged: (value) {
                        setState(() {
                          value == true ? _hobiler.add('Spor') : _hobiler.remove('Spor');
                        });
                      },
                    ),
                    CheckboxListTile(
                      hoverColor: Colors.deepOrange,
                      activeColor: Colors.deepOrange,
                      title: const Text('Müzik'),
                      value: _hobiler.contains('Müzik'),
                      onChanged: (value) {
                        setState(() {
                          value == true ? _hobiler.add('Müzik') : _hobiler.remove('Müzik');
                        });
                      },
                    ),
                    CheckboxListTile(
                      hoverColor: Colors.deepOrange,
                      activeColor: Colors.deepOrange,
                      title: const Text('Kitap Okuma'),
                      value: _hobiler.contains('Kitap Okuma'),
                      onChanged: (value) {
                        setState(() {
                          value == true ? _hobiler.add('Kitap Okuma') : _hobiler.remove('Kitap Okuma');
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange,foregroundColor: Colors.white),
                      onPressed: () => kaydet(context),
                      child: const Text('Kaydet'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
