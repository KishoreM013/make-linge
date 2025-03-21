import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:makelinge/firebase_options.dart';
import 'package:makelinge/firebase_utils/auth_methods.dart';
import 'package:makelinge/pages/home_page.dart';
import 'package:makelinge/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.dark()),
      home:
          // ignore: unnecessary_null_comparison
          AuthMethods().getCurrentUser() != null
              ? const HomePage()
              : const LoginPage(),
    );
  }
}
