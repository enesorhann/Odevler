import 'package:flutter/material.dart';
import 'database_helper.dart';

class KullaniciDetaylariSayfasi extends StatelessWidget {
  final int userId;


  const KullaniciDetaylariSayfasi({required this.userId, super.key});

  Future<Map<String, dynamic>?> _fetchUserDetails() async {
    return await DatabaseHelper().getUserInfoByUserId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Kullanıcı Detayları')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Kullanıcı bilgisi bulunamadı.'));
          }

          final userDetails = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            radius: 50,
                            child: Text(
                              userDetails['full_name']?[0]?.toUpperCase() ?? '?',
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            userDetails['full_name'] ?? 'Ad Soyad Bilinmiyor',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Kullanıcı ID: $userId',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailTile(
                  icon: Icons.cake,
                  title: 'Doğum Tarihi',
                  value: userDetails['birth_date'] ?? 'Belirtilmemiş',
                ),
                _buildDetailTile(
                  icon: Icons.person,
                  title: 'Cinsiyet',
                  value: userDetails['gender'] ?? 'Belirtilmemiş',
                ),
                _buildDetailTile(
                  icon: Icons.hiking,
                  title: 'Hobiler',
                  value: userDetails['hobbies'] ?? 'Belirtilmemiş',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailTile({required IconData icon, required String title, required String value}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.deepOrange),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
