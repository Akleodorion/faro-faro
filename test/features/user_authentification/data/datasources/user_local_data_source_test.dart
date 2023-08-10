import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_local_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'user_local_data_source_test.mocks.dart';

@GenerateMocks([sql.DatabaseFactory, sql.Database])
void main() {
  late MockDatabaseFactory mockDatabaseFactory;
  late MockDatabase mockDatabase;
  late UserLocalDataSourceImpl userLocalDataSourceImpl;
  late UserModel tUserModel;

  setUp(() {
    mockDatabaseFactory = MockDatabaseFactory();
    mockDatabase = MockDatabase();
    userLocalDataSourceImpl = UserLocalDataSourceImpl();
    tUserModel = const UserModel(
        email: 'test@gmail.com',
        username: 'chris',
        phoneNumber: '06 06 06 06 06');
  });

  group(
    "storeUserAuthInfo",
    () {
      test(
        "should call the getDatabasesPath method",
        () async {
          //act
          //arrange
          //assert
          sql.openDatabase('hd');
        },
      );

      test(
        "should open the db with the previously given dbPath",
        () async {
          //assert
          //act
          //arrange
        },
      );
    },
  );
}
