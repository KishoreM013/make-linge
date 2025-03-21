import 'package:flutter/material.dart';
import 'package:makelinge/firebase_utils/auth_methods.dart';
import 'package:makelinge/pages/login.dart';
import 'package:makelinge/widgets/bottom_bar.dart';
import 'package:makelinge/widgets/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthMethods authMethods = AuthMethods();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(onPressed: () {
            authMethods.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: PageView(
        
        children: [
          ProfileCard(),
          MyPosts(),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Text('Post ${index + 1}');
        },
      ),
    );
  }
}