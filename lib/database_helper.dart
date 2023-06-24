import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/task.dart';
import 'models/todo.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)');
        await db.execute(
            'CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)');
      },
      version: 1,
    );
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;
    Database db = await database();
    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<List<Task>> getTasks() async {
    Database db = await database();
    final List<Map<String, dynamic>> taskMap = await db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Task(
        id: taskMap[index]['id'],
        title: taskMap[index]['title'],
        description: taskMap[index]['description'],
      );
    });
  }

  Future<void> updateTaskTitle(int id, String title) async {
    Database db = await database();
    await db.rawQuery("UPDATE tasks SET title = '$title' WHERE id = '$id'");
  }

  Future<void> deleteTask(int? id) async {
    Database db = await database();
    await db.rawDelete("DELETE FROM tasks WHERE id = '$id'");
    await db.rawDelete("DELETE FROM todo WHERE taskId = '$id'");
  }

  Future<void> updateTaskDescription(int id, String description) async {
    Database db = await database();
    await db.rawQuery("UPDATE tasks SET description = '$description' WHERE id = '$id'");
  }

  Future<void> insertTodo(Todo todo) async {
    Database db = await database();
    await db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todo>> getTodo(int? taskId) async {
    Database db = await database();
    final List<Map<String, dynamic>> todoMap = await db.rawQuery('SELECT * FROM todo WHERE taskId = $taskId');
    return List.generate(todoMap.length, (index) {
      return Todo(
        id: todoMap[index]['id'],
        taskId: todoMap[index]['taskId'],
        title: todoMap[index]['title'],
        isDone: todoMap[index]['isDone'],
      );
    });
  }

  Future<void> updateTodoDone(int? id, int isDone) async {
    Database db = await database();
    await db.rawQuery("UPDATE todo SET isDone = '$isDone' WHERE id = '$id'");
  }
}
