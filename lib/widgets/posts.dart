import 'package:flutter/material.dart';
import 'package:makelinge/firebase_utils/auth_methods.dart';
import 'package:makelinge/student_pages/post_detials.dart';

class Posts extends StatelessWidget {
  Posts({super.key});
  final AuthMethods authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    final user = authMethods.getUserDetails() as Map<String, dynamic>;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetails(user: user)));
      },
      child: Card(
        child: Column(
          children: [
            Text(user['email']),
            Image.memory(user['image']),
            Text('Likes: ${user['likes']}'),
          ],
        ),
      ),
    );
  }
}
