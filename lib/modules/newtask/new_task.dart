import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class NewTask extends StatelessWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CubitApp cubit = BlocProvider.of(context);
    return BlocConsumer<CubitApp, AppStates>(
        builder: (context, state) {
          return tasksbuilderempty(task: cubit.Newtasks);
        },
        listener: (context, state) {});
  }
}
