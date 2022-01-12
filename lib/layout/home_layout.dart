import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitApp()..createdatabase(),
      child: BlocConsumer<CubitApp, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          CubitApp cubit = BlocProvider.of(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text("${cubit.names[cubit.creent]}"),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDataBaseLoadingState,
              builder: (context) => cubit.screen[cubit.creent],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  if (cubit.isshow) {
                    if (formkey.currentState!.validate()) {
                      cubit.insertdata(
                          title: titlecontroller.text,
                          dates: datecontroller.text,
                          time: timecontroller.text);
                      //cubit.changer(isshow: false, iconfbutton: Icons.edit);
                    }
                  } else {
                    scaffoldkey.currentState!
                        .showBottomSheet(
                          (context) => Container(
                            width: double.infinity,
                            child: Form(
                              key: formkey,
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                color: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultformfiled(
                                      labeltext: "Task Title",
                                      keyboard: TextInputType.text,
                                      controllers: titlecontroller,
                                      preicon: Icons.title,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "Title Can't be Empty";
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    defaultformfiled(
                                      labeltext: "Time Title",
                                      keyboard: TextInputType.datetime,
                                      controllers: timecontroller,
                                      preicon: Icons.watch_later_outlined,
                                      ontap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timecontroller.text =
                                              value!.format(context);
                                        });
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "Time Can't be Empty";
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    defaultformfiled(
                                      labeltext: "Date Title",
                                      keyboard: TextInputType.datetime,
                                      controllers: datecontroller,
                                      preicon: Icons.calendar_today,
                                      ontap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2022, 2),
                                        ).then((value) {
                                          print(DateFormat.yMMMd()
                                              .format(value!));
                                          datecontroller.text =
                                              DateFormat.yMMMd()
                                                  .format(value)
                                                  .toString();
                                        });
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "Date Can't be Empty";
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .closed
                        .then((value) {
                      cubit.changer(isshow: false, iconfbutton: Icons.edit);
                    });

                    cubit.changer(isshow: true, iconfbutton: Icons.add);
                  }
                },
                child: Icon(cubit.iconfbutton)),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.creent,
              onTap: (index) {
                cubit.changeindex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "task"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archive"),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<String> getname() async {
    return "Moonysuper";
  }
}
