import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetails extends StatelessWidget {
  PostDetails({super.key, required this.user});
  final Map<String, dynamic> user;
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Column(
        children: [
          Text(user['email']),
          Image.memory(user['image']),
          Text(user['title']),
          Text(user['content']),
          Text('Likes: ${user['likes']}'),
          TextField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Add a comment',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('posts').doc(user['email']).update({
                'comments': [...user['comments'], commentController.text],
              });
            },
            child: Text('Add Comment'),
          ),
        ],
      ),
    );
  }
}