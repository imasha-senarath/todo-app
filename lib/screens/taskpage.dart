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

  int? _taskId = 0;
  String? _taskTitle = "";
  String? _taskDescription = "";

  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;
      _taskTitle = widget.task?.title;
      _taskId = widget.task?.id;
      _taskDescription = widget.task?.description;
      _loadTodo();
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    super.dispose();
  }

  Future<void> _loadTodo() async {
    final todo = await _databaseHelper.getTodo(_taskId);
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
                          focusNode: _titleFocus,
                          onSubmitted: (value) async {
                            if (value != "") {
                              if (widget.task == null) {

                                Task newTask = Task(
                                  title: value,
                                  description: '',
                                );

                                try {
                                  _taskId = await _databaseHelper.insertTask(newTask);

                                  _descriptionFocus.requestFocus();
                                  setState(() {
                                    _contentVisible = true;
                                    _taskTitle = value;
                                  });
                                } catch (e) {
                                  Fluttertoast.showToast(
                                    msg: e.toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                }
                              } else {
                                _databaseHelper.updateTaskTitle(_taskId!, value);
                              }
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
                Visibility(
                  visible: _contentVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12.0,
                    ),
                    child: TextField(
                      focusNode: _descriptionFocus,
                      onSubmitted: (value) async {
                        if(value != "") {
                          if(_taskId != 0) {
                            await _databaseHelper.updateTaskDescription(_taskId!, value);
                            _taskDescription = value;
                          }
                        }
                        _todoFocus.requestFocus();

                      },
                      controller: TextEditingController()
                        ..text = _taskDescription!,
                      decoration: const InputDecoration(
                          hintText: "Enter description for the task",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          )),
                    ),
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: _todo.length,
                      itemBuilder: (context, index) {
                        final todo = _todo[index];
                        return GestureDetector(
                          onTap: () async {
                            if(todo.isDone == 0) {
                              await _databaseHelper.updateTodoDone(todo.id, 1);
                            } else {
                              await _databaseHelper.updateTodoDone(todo.id, 0);
                            }
                            _loadTodo();
                          },
                          child: TodoWidget(
                            text: todo.title,
                            isDone: todo.isDone == 0 ? false : true,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: Padding(
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
                          focusNode: _todoFocus,
                          controller: TextEditingController()..text = "",
                          onSubmitted: (value) async {
                            if (value != "") {
                              if (_taskId != null) {
                                DatabaseHelper dbHelper = DatabaseHelper();

                                Todo newTodo = Todo(
                                  taskId: _taskId,
                                  title: value,
                                  isDone: 0,
                                );

                                try {
                                  await dbHelper.insertTodo(newTodo);
                                  _loadTodo();
                                  _todoFocus.requestFocus();
                                } catch (e) {
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
                          },
                          decoration: const InputDecoration(
                              hintText: 'Enter todo item...',
                              border: InputBorder.none),
                        ),
                      )
                    ]),
                  ),
                )
              ],
            ),
            Visibility(
              visible: _contentVisible,
              child: Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () async {
                    if(_taskId != 0) {
                      try {
                        await _databaseHelper.deleteTask(_taskId);
                        Fluttertoast.showToast(
                          msg: 'Task deleted.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        if (kDebugMode) {
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
              ),
            )
          ],
        )),
      ),
    );
  }
}
