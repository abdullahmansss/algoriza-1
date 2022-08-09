import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test1/core/models/task_model.dart';
import 'package:test1/core/util/blocs/app/states.dart';
import 'package:path/path.dart' as p;

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  late Database database;

  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');

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
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY,'
          ' title TEXT, date TEXT, startTime TEXT,'
          ' endTime TEXT,'
          ' reminder INTEGER,'
          ' color INTEGER,'
          ' completed INTEGER,'
          ' favorite INTEGER)',
        );

        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('AppDatabaseOpened');
        database = db;

        getTasksData();
      },
    );
  }

  TextEditingController usernameController = TextEditingController();

  void insertTaskData({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required int reminder,
  }) async {
    await database.transaction(
      (txn) async {
        int id = await txn.rawInsert(
          'INSERT INTO tasks (title, date, startTime, endTime, reminder, color, completed, favorite)'
          ' VALUES ("$title", "$date", "$startTime", "$endTime", $reminder, $selectedColorIndex, 1, 1)',
        );
        debugPrint('Task Inserted');
      },
    ).then((value) {
      debugPrint('Task Data Inserted');

      // usernameController.clear();
      getTasksData();

      emit(AppDatabaseUserCreated());
    });
  }

  List<TaskModel> tasks = [];

  void getTasksData() async {
    emit(AppDatabaseLoading());

    tasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {
      debugPrint('Tasks Data Fetched');
      debugPrint(value.toString());

      for (var element in value) {
        tasks.add(TaskModel.fromJson(element));
      }

      debugPrint(tasks.toString());
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

  void updateCompleteTask(int taskId) async {
    int completed = tasks.firstWhere((element) => element.id == taskId).completed == 1 ? 0 : 1;

    database.rawUpdate(
        'UPDATE tasks SET completed = ? WHERE id = $taskId', [completed]).then((value) {

      debugPrint('Task Data Updated');
      getTasksData();
    });
  }

  void updateFavoriteTask(int taskId) async {
    int favorite = tasks.firstWhere((element) => element.id == taskId).favorite == 1 ? 0 : 1;

    database.rawUpdate(
        'UPDATE tasks SET favorite = ? WHERE id = $taskId', [favorite]).then((value) {

      debugPrint('Task Data Updated');
      getTasksData();
    });
  }

  void updateUserData() async {
    database.rawUpdate(
        'UPDATE users SET name = ? WHERE id = ${selectedUser['id']}', [
      (usernameController.text),
    ]).then((value) {
      selectedUser = {};
      usernameController.clear();

      debugPrint('User Data Updated');
      getTasksData();
    });
  }

  List<MaterialColor> taskColors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  int selectedColorIndex = 0;

  void changeColor(index) {
    selectedColorIndex = index;
    emit(TaskColorChanged());
  }
}
