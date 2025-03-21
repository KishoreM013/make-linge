import 'package:flutter/material.dart';
import 'package:makelinge/pages/home_page.dart';
import 'package:makelinge/student_pages/profile_page.dart';
import 'package:makelinge/student_pages/search_page.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
          }, icon: Icon(Icons.home)),
          IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SearchPage()));
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
          }, icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
