import 'package:flutter/material.dart';
import 'package:todo_app/screens/taskpage.dart';
import 'package:todo_app/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                    child: ListView(
                      children: const [
                        TaskCardWidget(
                          title: "Get Started!",
                          desc:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam porta neque justo, sit amet iaculis diam cursus gravida. Phasellus elit ante, congue a diam et, sollicitudin feugiat tortor.',
                        ),
                        TaskCardWidget(
                          title: "Unnamed Task",
                          desc: 'No description',
                        ),
                        TaskCardWidget(
                          title: "Unnamed Task",
                          desc: 'No description',
                        ),
                        TaskCardWidget(
                          title: "Unnamed Task",
                          desc: 'No description',
                        ),
                        TaskCardWidget(
                          title: "Unnamed Task",
                          desc: 'No description',
                        ),
                        TaskCardWidget(
                          title: "Unnamed Task",
                          desc: 'No description',
                        ),
                      ],
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
                        builder: (context) => TaskPage()
                      ),
                    );
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: const Color(0xFF7349FE),
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
