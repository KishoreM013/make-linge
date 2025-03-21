import 'package:flutter/material.dart';
import 'package:makelinge/widgets/bottom_bar.dart';
import 'package:makelinge/student_pages/put_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PutPost()));
          }, icon: Icon(Icons.add)),
        ],
      ),
      body: PageView(

      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
