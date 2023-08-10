import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

abstract class DatabaseHelper {
  Future<String?> getDbPath();

  Future<sql.Database>? openDb(
      {String onCreateColumnNamesAndTypes = '',
      required String tableName,
      required String dbName});

  Future<void>? dbInsert(
      {required String tableName,
      required String dbName,
      required Map<String, dynamic> values});
}

class DatabaseHelperImpl implements DatabaseHelper {
  @override
  Future<void>? dbInsert(
      {required String tableName,
      required String dbName,
      required Map<String, dynamic> values}) async {
    final db = await openDb(tableName: tableName, dbName: dbName);
    db!.insert(tableName, values);
  }

  @override
  Future<String?> getDbPath() async {
    return sql.getDatabasesPath();
  }

  @override
  Future<sql.Database>? openDb({
    String onCreateColumnNamesAndTypes = '',
    required String tableName,
    required String dbName,
  }) async {
    final dbPath = await getDbPath();
    path.join(dbPath!, dbName);
    final db = await sql.openDatabase(
      dbPath,
      onCreate: (db, version) {
        if (onCreateColumnNamesAndTypes.isEmpty) {
          return null;
        }
        return db
            .execute('CREATE TABLE $tableName($onCreateColumnNamesAndTypes) ');
      },
    );

    return db;
  }
}
