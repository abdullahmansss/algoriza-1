import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test1/core/util/blocs/app/states.dart';
import 'package:path/path.dart' as p;

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  late Database database;

  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'users.db');

    debugPrint('AppDatabaseInitialized');

    openAppDatabase(
      path: path,
    );

    emit(AppDatabaseInitialized());
  }

  void openAppDatabase({
    required String path,
  }) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)',
        );

        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('AppDatabaseOpened');
        database = db;

        getUsersData();
      },
    );
  }

  TextEditingController usernameController = TextEditingController();

  void insertUserData() {
    if(selectedUser.isNotEmpty) {
      updateUserData();
      return;
    }

    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO users(name) VALUES("${usernameController.text}")');
    }).then((value) {
      debugPrint('User Data Inserted');

      usernameController.clear();
      getUsersData();

      emit(AppDatabaseUserCreated());
    });
  }

  List<Map> users = [];

  void getUsersData() async {
    emit(AppDatabaseLoading());

    database.rawQuery('SELECT * FROM users').then((value) {
      debugPrint('Users Data Fetched');
      users = value;
      debugPrint(users.toString());
      emit(AppDatabaseUsers());
    });
  }

  Map selectedUser = {};

  void selectUserToUpdate({
    required Map user,
  }) {
    selectedUser = user;

    usernameController.text = selectedUser['name'];

    emit(AppSelectUser());
  }

  void updateUserData() async {
    database.rawUpdate(
        'UPDATE users SET name = ? WHERE id = ${selectedUser['id']}', [
      (usernameController.text),
    ]).then((value) {
      selectedUser = {};
      usernameController.clear();

      debugPrint('User Data Updated');
      getUsersData();
    });
  }
}