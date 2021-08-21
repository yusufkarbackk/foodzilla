import 'package:foodzilla/models/restaurant_detail.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;
  static String _tableName = 'favourites';

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get getDatabase async {
    _database = await _initialDb();
    return _database;
  }

  Future<Database> _initialDb() async {
    String path = await getDatabasesPath();

    Future<Database> db = openDatabase(join(path, 'favourite_db.db'),
        onCreate: (db, version) async {
      await db.execute('''  
        CREATE TABLE $_tableName ( 
        restaurant_id TEXT PRIMARY KEY, 
        restaurant_name TEXT)
      ''');
    }, version: 1);
    return db;
  }

  Future<void> insertRestaurant(RestaurantDetail restaurant) async {
    final Database db = await getDatabase;
    await db.insert(_tableName, restaurant.toJson());
    print("restaurant saved");
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await getDatabase;

    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<RestaurantDetail>> getFavouritedRestaurants() async {
    final Database db = await getDatabase;
    List<Map<String, dynamic>> result = await db.query(_tableName);

    return result.map((e) => RestaurantDetail.fromJson(e)).toList();
  }
}
