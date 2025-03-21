import 'package:flutter/material.dart';
import 'package:makelinge/firebase_utils/auth_methods.dart';
import 'package:makelinge/pages/signup.dart';
import 'package:makelinge/pages/home_page.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthMethods _authMethods = AuthMethods();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    await _authMethods.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TextField(controller: _emailController,),
                TextField(controller: _passwordController,),
                ElevatedButton(onPressed: _login,
                  child: const Text('Login'),
                ),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                }, child: const Text('Signup')),
              ],
            ),
    );
  }
}