import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/image.dart';
import '../student_pages/profile_page.dart';
class PutPost extends StatelessWidget {
  const PutPost({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    Uint8List _image = Uint8List(0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Put Post'),
      ),
      body: Column(
        children: [
          Text('Put Post'),
          ElevatedButton(
            child: Text('Upload Image'),
            onPressed: () async {
              _image = await ImageUtils.getImageFromGallery();
            },
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Title',
            ),
          ),
          TextField(
            controller: contentController,
            decoration: InputDecoration(
              hintText: 'Content',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('posts').doc(FirebaseAuth.instance.currentUser?.email).set({
                'title': titleController.text,
                'content': contentController.text,
                'image': _image,
                'email': FirebaseAuth.instance.currentUser?.email,
                'likes': 0,
                'comments': [],
                'createdAt': DateTime.now(),
              });
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: Text('Submit'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
