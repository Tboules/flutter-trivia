import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();
  late StreamSubscription<User?> _listener;

  @override
  void initState() {
    _listener = auth.user.listen((User? user) {
      if (user == null) return;
      if (user != null) {
        Navigator.pushNamed(context, '/home');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        width: double.infinity,
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final AuthService auth = AuthService();
  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: const [
            Icon(
              FontAwesomeIcons.question,
              size: 100,
            ),
            Text(
              'Flutter Trivia!',
              style: TextStyle(
                height: 2,
                fontSize: 24,
              ),
            )
          ],
        ),
        Flex(
          direction: Axis.vertical,
          children: [
            LoginButton(
              bgColor: Colors.black12,
              title: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              loginMethod: auth.googleSignIn,
            ),
            LoginButton(
              bgColor: Colors.white10,
              title: 'Annonymous',
              icon: FontAwesomeIcons.user,
              loginMethod: auth.anonSignIn,
            )
          ],
        )
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function loginMethod;
  final Color bgColor;
  final IconData icon;
  final String title;

  const LoginButton(
      {Key? key,
      required this.loginMethod,
      required this.bgColor,
      required this.icon,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5,
      ),
      child: TextButton.icon(
        icon: Icon(icon),
        label: Text(title),
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.all(20),
          primary: Colors.white,
          fixedSize: const Size.fromWidth(300),
        ),
        onPressed: () async {
          User? user = await loginMethod();
          print(user);
          if (user != null) Navigator.pushNamed(context, '/home');
        },
      ),
    );
  }
}
