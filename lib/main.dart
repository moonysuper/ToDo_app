import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import 'shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => CubitApp(),
        ),
      ],
      child: BlocConsumer<CubitApp, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    color: Colors.white,
                    elevation: 0,
                    backwardsCompatibility: false,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                    ))),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                textTheme: TextTheme(
                    body1: TextStyle(
                  color: Colors.white,
                )),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: HexColor('#333739'),
                  unselectedItemColor: Colors.white,
                ),
                scaffoldBackgroundColor: HexColor('#333739'),
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    color: HexColor('#333739'),
                    elevation: 0,
                    backwardsCompatibility: false,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                    ))),
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
