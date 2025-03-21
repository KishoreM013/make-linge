import 'package:flutter/material.dart';
import 'dart:typed_data';
class Post extends StatelessWidget {
  const Post({super.key, required this.post, required this.user, required this.likes, required this.comments, required this.timestamp});

  final Uint8List post; 
  final String user;
  final int likes;
  final List<dynamic> comments;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.memory(post),
          Text(user),
          Text("likes: ${likes.toString()}" ),
          Text("comments: ${comments.length.toString()}"),
          Text("timestamp: ${timestamp.toString()}"),
        ],
      ),
    );
  }
}