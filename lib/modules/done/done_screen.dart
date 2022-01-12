import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class Done extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CubitApp cubit = BlocProvider.of(context);
    return BlocConsumer<CubitApp, AppStates>(
        builder: (context, state) {
          return tasksbuilderempty(task: cubit.Donetasks);
        },
        listener: (context, state) {});
  }
}
