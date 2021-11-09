import 'package:flutter/material.dart';
import 'package:trivia_app/screens/screens.dart';
import 'package:trivia_app/services/services.dart';
import 'package:trivia_app/shared/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthService auth = AuthService();
  final TriviaService triv = TriviaService();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return _wideScreen();
        } else {
          return _smallScreen();
        }
      },
    );
  }

  Widget _smallScreen() {
    return Scaffold(
      appBar: const CustAppBar(
        title: 'home',
        navigate: true,
      ),
      drawer: const Drawer(
        child: QuizCategories(),
      ),
      body: Quiz(),
    );
  }

  Widget _wideScreen() {
    return Scaffold(
      appBar: const CustAppBar(
        title: 'home',
      ),
      body: Center(
        child: Row(
          children: [
            const Expanded(
              child: QuizCategories(),
              flex: 2,
            ),
            Expanded(
              child: Quiz(),
              flex: 5,
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
