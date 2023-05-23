import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title, desc;

  const TaskCardWidget({Key? key, required this.title, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "Unnamed Task",
            style: const TextStyle(
                color: Color(0xFF211551),
                fontSize: 22.8,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: Text(
              desc ?? "none",
              style: const TextStyle(
                color: Color(0xFF868290),
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: EdgeInsets.only(
              right: 15.0
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF7349FE),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: const Image(
              image: AssetImage(
                'assets/images/check_icon.png',
              )
            ),
          ),
          const Text("ToDo Widget"),
        ],
      ),
    );
  }
}

