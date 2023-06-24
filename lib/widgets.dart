import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String? title, desc;

  const TaskCardWidget({Key? key, this.title, this.desc})
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
  final String text;
  final bool isDone;

  const TodoWidget({Key? key, this.text = "Unnamed Todo", this.isDone = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: const EdgeInsets.only(
              right: 15.0,
            ),
            decoration: BoxDecoration(
              color: isDone ? const Color(0xFF7349FE) : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
              border: isDone
                  ? null
                  : Border.all(
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
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: isDone ? const Color(0xFF211551) : const Color(0xFF868290),
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
