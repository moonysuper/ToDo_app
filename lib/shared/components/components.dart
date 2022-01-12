import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

// TextFormField components

Widget defaultformfiled({
  required TextInputType keyboard,
  required String labeltext,
  required TextEditingController controllers,
  IconData? preicon,
  var sufffun,
  bool obscureTexts = false,
  bool needpassicon = false,
  required var validate,
  var ontap,
  var onchange,
}) =>
    TextFormField(
      onTap: ontap,
      onChanged: onchange,
      validator: validate,
      controller: controllers,
      keyboardType: keyboard,
      obscureText: obscureTexts,
      decoration: InputDecoration(
          labelText: "$labeltext",
          border: OutlineInputBorder(),
          prefixIcon: Icon(preicon),
          suffixIcon: needpassicon
              ? IconButton(
                  icon: obscureTexts
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.visibility_off),
                  onPressed: sufffun,
                )
              : null),
    );

Widget buildtask(Map datamodel, context) => Dismissible(
      key: Key(datamodel['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                "${datamodel["time"]}",
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${datamodel["title"]}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  Text("${datamodel["date"]}",
                      style: TextStyle(color: Colors.grey[500]))
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
                onPressed: () {
                  CubitApp.get(context)
                      .updateDatabase(status: "Done", id: datamodel["id"]);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  CubitApp.get(context)
                      .updateDatabase(status: "Archive", id: datamodel["id"]);
                },
                icon: Icon(
                  Icons.archive_outlined,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        CubitApp.get(context).DeleteDatabase(id: datamodel['id']);
      },
    );

Widget tasksbuilderempty({required List<Map> task}) => ConditionalBuilder(
      condition: task.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildtask(task[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: task.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 100.0,
            ),
            Text(
              "No Tasks Yet , Please Add Some Tasks",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Container(
      color: Colors.grey,
      width: double.infinity,
      height: 1,
    );
