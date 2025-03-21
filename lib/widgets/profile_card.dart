import 'package:flutter/material.dart';
import 'package:makelinge/firebase_utils/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final AuthMethods authMethods = AuthMethods();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Uint8List convertListToUint8List(List<dynamic> list) {
    List<int> intList = list.map((element) => element as int).toList();
    return Uint8List.fromList(intList);
  }

  @override
  Widget build(BuildContext context) {
    // Get the currently authenticated user.
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Center(child: Text('No user logged in'));
    }

    // Fetch additional user data from Firestore.
    return FutureBuilder<DocumentSnapshot>(
      future: firestore.collection('users').doc(currentUser.uid).get(),
      builder: (context, snapshot) {
        // While the data is loading, show a progress indicator.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // If an error occurs, display an error message.
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        // Check if user data exists.
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('User data not found'));
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>;
        userData['profilePicture'] = convertListToUint8List(userData['profilePicture']);
        return Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  userData['profilePicture'] != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(userData['profilePicture']),
                      )
                    : const Icon(Icons.person, size: 50),
                const SizedBox(height: 8.0),
                Text(
                  userData['name'] ?? 'No Name',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  userData['email'] ?? 'No Email',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  userData['description'] ?? 'No Description',
                  style: const TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text('Followers: ${userData['followers'].length}'),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text('Following: ${userData['following'].length}'),
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
