import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in using email and password.
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // Sign in and return the user credential.
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Provide a more descriptive error message.
      throw Exception('Sign in failed: $e');
    }
  }

  // Sign up a new user with email, password, name, profile picture, description, and student status.
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required Uint8List profilePicture,
    required String description,
    required bool student,
  }) async {
    try {
      // Create the user account.
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // After the account is created, store additional user data in Firestore.
      // Note: Consider uploading the profile picture to Firebase Storage and then saving its URL.
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,
        'profilePicture':
            profilePicture, // This saves the binary data; consider using Storage for images.
        'student': student,
        'description': description,
        'followers': [],
        'following': [],
        'posts': [],
        'likedPosts': [],
        'dislikedPosts': [],
        'comments': [],
      });

      await _firestore.collection('search_data').doc(userCredential.user!.uid).set({
        '$email': email,
      });

      return userCredential;
    } catch (e) {
      // Provide a more descriptive error message.
      throw Exception('Sign up failed: $e');
    }
  }

  // Sign out the current user.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<DocumentSnapshot> getUserDetails() async {
    return await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
  }

  Future<List<Map<String, dynamic>>> getPostDetails() async {
    return await _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get()
        .then(
          (querySnapshot) =>
              querySnapshot.docs
                  .map((doc) => doc.data())
                  .toList(),
        );
  }

  Future<List<Map<String, dynamic>>> getPostDetailsByEmail() async {
    return await _firestore
        .collection('posts')
        .where('email', isEqualTo: _auth.currentUser!.email)
        .orderBy('createdAt', descending: true)
        .get()
        .then(
          (querySnapshot) =>
              querySnapshot.docs
                  .map((doc) => doc.data())
                  .toList(),
        );
  }
}
