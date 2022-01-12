//import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archive/archive.dart';
import 'package:todo_app/modules/done/done_screen.dart';
import 'package:todo_app/modules/newtask/new_task.dart';
import 'package:todo_app/shared/cubit/states.dart';

class CubitApp extends Cubit<AppStates> {
  CubitApp() : super(AppInitialState());

  static CubitApp get(context) => BlocProvider.of(context);
  var theme = true;
  int creent = 0;
  bool isshow = false;
  IconData iconfbutton = Icons.edit;
  Database? database;
  List screen = [
    NewTask(),
    Done(),
    Archive(),
  ];
  List<String> names = [
    "News task",
    "Done",
    "Archive",
  ];
  List<Map> Newtasks = [];
  List<Map> Donetasks = [];
  List<Map> Archivetasks = [];

  void changetheme() {
    theme = !theme;
    emit(NewsChangeThemeStates());
  }

  void changeindex(int index) {
    creent = index;
    emit(AppChangeNavBarState());
  }

  void createdatabase() {
    openDatabase("deta.db", version: 1, onCreate: (database, version) async {
      await database
          .execute(
              "Create table task (id INTEGER PRIMARY KEY ,title TEXT,date TEXT,time TEXT ,status TEXT)")
          .then((value) {
        print("database created successfully");
      }).catchError((ex) {
        print("Some error founded ${ex.toString()}");
      });
    }, onOpen: (database) {
      getdata(database);
      print("database is opended");
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertdata({
    required String title,
    required String dates,
    required String time,
  }) async {
    database!.transaction((txn) {
      txn
          .rawInsert(
              "insert into task (title,date,time,status) values ('$title','$dates','$time','New')")
          .then((value) {
        print("$value record successfully");
        emit(AppInsertDataBaseState());

        getdata(database);
      }).catchError((error) {
        print("you have Error : $error");
      });

      return null;
    });
  }

  void getdata(database) {
    Newtasks = [];
    Donetasks = [];
    Archivetasks = [];

    emit(AppGetDataBaseLoadingState());

    database.rawQuery("select * from task").then((value) {
      value.forEach((element) {
        if (element['status'] == "New")
          Newtasks.add(element);
        else if (element['status'] == "Done")
          Donetasks.add(element);
        else
          Archivetasks.add(element);
      });

      emit(AppGetDataBaseState());
    });
  }

  void updateDatabase({
    required String status,
    required int id,
  }) {
    database!.rawUpdate('UPDATE task SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(AppUpdateDataBaseState());
      getdata(database);
    });
  }

  void DeleteDatabase({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM task WHERE id = ?', [id]).then((value) {
      emit(AppDeleteDataBaseState());
      getdata(database);
    });
  }

  void changer({
    required bool isshow,
    required IconData iconfbutton,
  }) {
    this.isshow = isshow;
    this.iconfbutton = iconfbutton;
    emit(AppChangerState());
  }
}
