import 'package:flutter/material.dart';
import 'package:mobilodev5/kullanici_detayi_sayfasi.dart';
import 'database_helper.dart';

class KullanicilarSayfasi extends StatefulWidget {
  const KullanicilarSayfasi({super.key});

  @override
  _KullanicilarSayfasiState createState() => _KullanicilarSayfasiState();
}

class _KullanicilarSayfasiState extends State<KullanicilarSayfasi> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;
  String? _errorMessage;

  int? _expandedUserId;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final users = await _dbHelper.getAllUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Kullanıcılar yüklenirken bir hata oluştu: $e';
        _isLoading = false;
      });
    }
  }

  void _toggleExpansion(int userId) {
    setState(() {
      _expandedUserId = _expandedUserId == userId ? null : userId;
    });
  }

  void _goToUserDetailsPage(int userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KullaniciDetaylariSayfasi(userId: userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Kullanıcılar',style: TextStyle(color: Colors.white),)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _users.isEmpty
                  ? const Center(child: Text('Hiç kullanıcı bulunamadı.'))
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        final userId = user['id'];
                        final isExpanded = _expandedUserId == userId;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  child: Text(user['username'][0].toUpperCase()),
                                ),
                                title: Text(user['username']),
                                subtitle: Text('Kullanıcı ID: $userId'),
                                onTap: () => _toggleExpansion(userId),
                              ),
                              if (isExpanded)
                                Container(
                                  color: Colors.grey[100],
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange,foregroundColor: Colors.white),
                                        onPressed: () => _goToUserDetailsPage(userId),
                                        icon: const Icon(Icons.info),
                                        label: const Text('Detaylar'),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward,color: Colors.white,
        ),
      ),
    );
  }
}
