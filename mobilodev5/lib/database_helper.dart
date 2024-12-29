import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 2, // Sürümü artırıyoruz
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE user_info ADD COLUMN user_id INTEGER;');
          await db.execute('CREATE UNIQUE INDEX idx_user_id ON user_info(user_id);'); // Daha hızlı sorgular için
        }
      },
    );
  }

  Future<void> _createTables(Database db) async {
    // users tablosu: kullanıcı adı ve parola için
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT
      )
    ''');

    // user_info tablosu: kullanıcı bilgileri için
    await db.execute('''
      CREATE TABLE user_info(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT,
        birth_date TEXT,
        gender TEXT,
        hobbies TEXT,
        user_id INTEGER,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');
  }

  // Kullanıcı bilgilerini ekle veya güncelle
  Future<void> insertOrUpdateUserInfo(Map<String, dynamic> userInfo) async {
    try {
      final db = await database;

      // Öncelikle user_id'ye göre bir kayıt var mı kontrol et
      final result = await db.query(
        'user_info',
        where: 'user_id = ?',
        whereArgs: [userInfo['user_id']],
      );

      if (result.isNotEmpty) {
        // Eğer kayıt varsa güncelle
        await db.update(
          'user_info',
          userInfo,
          where: 'user_id = ?',
          whereArgs: [userInfo['user_id']],
        );
      } else {
        // Eğer kayıt yoksa yeni bir kayıt ekle
        await db.insert('user_info', userInfo, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } catch (e) {
      print("Error in insertOrUpdateUserInfo: $e");
    }
  }

  // Kullanıcı bilgilerini alma (user_info tablosu)
  Future<Map<String, dynamic>?> getUserInfoByUserId(int userId) async {
    try {
      final db = await database;
      final result = await db.query(
        'user_info',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      print("Error fetching user info: $e");
      return null;
    }
  }

  // Kullanıcı ekleme (users tablosu)
  Future<void> insertUser(Map<String, dynamic> user) async {
    try {
      final db = await database;
      await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print("Error inserting user: $e");
    }
  }

  // Tüm kullanıcıları alma (users tablosu)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final db = await database;
      return await db.query('users');
    } catch (e) {
      print("Error fetching all users: $e");
      return [];
    }
  }

  // Kullanıcı doğrulama (users tablosu)
  Future<Map<String, dynamic>?> getUserByUsernameAndPassword(String username, String password) async {
    try {
      final db = await database;
      final result = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }
}
