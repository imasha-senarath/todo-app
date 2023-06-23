import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/widgets.dart';

import '../database_helper.dart';
import '../models/task.dart';
import '../models/todo.dart';

class TaskPage extends StatefulWidget {
  final Task? task;

  const TaskPage({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Todo> _todo = [];

  String? _taskTitle = "";

  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task?.title;
      _loadTodo();
    }
    Fluttertoast.showToast(
      msg: (widget.task?.id).toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
    super.initState();
  }

  Future<void> _loadTodo() async {
    final todo = await _databaseHelper.getTodo();
    setState(() {
      _todo = todo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 6.0,
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
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async {
                            if (value != "") {
                              if (widget.task == null) {
                                DatabaseHelper dbHelper = DatabaseHelper();

                                Task newTask = Task(
                                  title: value,
                                  description: '',
                                );

                                try {
                                  await dbHelper.insertTask(newTask);
                                  Fluttertoast.showToast(
                                    msg: 'Task added successfully',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                } catch (e) {
                                  if (kDebugMode) {
                                    print('[test66] $e');
                                  }
                                }
                              } else {}
                            }
                          },
                          controller: TextEditingController()
                            ..text = _taskTitle!,
                          decoration: const InputDecoration(
                            hintText: "Enter task title",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF211551),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Enter description for the task",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        )),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _todo.length,
                    itemBuilder: (context, index) {
                      final todo = _todo[index];
                      return const TodoWidget(

                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(children: [
                    Container(
                      width: 20.0,
                      height: 20.0,
                      margin: const EdgeInsets.only(
                        right: 15.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          color: const Color(0xFF868290),
                          width: 1.5,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Image(
                          image: AssetImage(
                            'assets/images/check_icon.png',
                          ),
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) async {
                          if (value != "") {
                            if (widget.task != null) {
                              DatabaseHelper dbHelper = DatabaseHelper();

                              Todo newTodo = Todo(
                                taskId: widget.task?.id,
                                title: value,
                                isDone: 0,
                              );

                              try {
                                await dbHelper.insertTodo(newTodo);
                                Fluttertoast.showToast(
                                  msg: 'Task added successfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                );
                              } catch (e) {
                                if (kDebugMode) {
                                  print('[test66] $e');
                                  Fluttertoast.showToast(
                                    msg: e.toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                }
                              }
                            }
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter todo item...',
                            border: InputBorder.none),
                      ),
                    )
                  ]),
                )
              ],
            ),
            Positioned(
              bottom: 24.0,
              right: 24.0,
              child: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                    msg: "(widget.id).toString()",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  );
                  /*         Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TaskPage()),
                  );*/
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFE3577),
                      borderRadius: BorderRadius.circular(60.0)),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Image(
                      image: AssetImage("assets/images/delete_icon.png"),
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
