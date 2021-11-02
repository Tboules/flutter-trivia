import 'package:flutter/material.dart';
import 'package:trivia_app/services/auth.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: Center(
        child: TextButton(
          child: const Text(
            'logout',
          ),
          onPressed: () {
            auth.signOut();
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
