import 'package:flutter/material.dart';
import 'package:trivia_app/screens/screens.dart';
import 'package:trivia_app/services/services.dart';
import 'package:trivia_app/shared/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  AuthService auth = AuthService();
  TriviaService triv = TriviaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustAppBar(
        title: 'home',
      ),
      body: _wideScreen(),
    );
  }

  Widget _wideScreen() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1600),
        child: Row(
          children: [
            const Expanded(
              child: QuizCategories(),
              flex: 2,
            ),
            Expanded(
              child: Quiz(),
              flex: 6,
            ),
            const Expanded(
              child: UserData(),
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
