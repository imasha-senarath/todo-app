import 'package:flutter/material.dart';
import 'package:todo_app/screens/taskpage.dart';
import 'package:todo_app/widgets.dart';

import '../database_helper.dart';
import '../models/task.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _addDataManually() {
    _tasks = [
      const Task(id: 4, title: 'Task 4', description: 'Task 4'),
      const Task(id: 5, title: 'Task 5', description: 'Task 4'),
      const Task(id: 6, title: 'Task 6', description: 'Task 4'),
    ];
  }

  Future<void> _loadTasks() async {
    final tasks = await _databaseHelper.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          color: const Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 32.0,
                      bottom: 32.0,
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 50,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskPage(
                                    task: task,
                                  ),
                                )).then((value) {
                                  setState(() {
                                    _loadTasks();
                                  });
                            });
                          },
                          child: TaskCardWidget(
                            title: task.title,
                            desc: task.description,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TaskPage(
                                task: null,
                              )),
                    ).then((value) => {
                          setState(() {
                            _loadTasks();
                          })
                        });
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF7349FE), Color(0xFF7557DE)],
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0)),
                        borderRadius: BorderRadius.circular(60.0)),
                    child: const Image(
                      image: AssetImage("assets/images/add_icon.png"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
