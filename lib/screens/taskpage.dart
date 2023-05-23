import 'package:flutter/material.dart';
import 'package:todo_app/widgets.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 6.0
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Image(
                            image: AssetImage(
                              'assets/images/back_arrow_icon.png',
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter task title",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF211551),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                      hintText: "Enter description for the task",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0,

                      )
                  ),
                ),
                const TodoWidget(),
              ],
            )),
      ),
    );
  }
}
