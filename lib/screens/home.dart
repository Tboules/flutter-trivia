import 'package:flutter/material.dart';
import 'package:trivia_app/services/services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  AuthService auth = AuthService();
  TriviaService triv = TriviaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(
                'logout',
              ),
              onPressed: () async {
                await auth.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            TextButton(
              child: const Text('get categories'),
              onPressed: () async {
                List<Category> cat = await triv.fetchCategories();
                cat.forEach((element) => print(element.id));
              },
            ),
          ],
        ),
      ),
    );
  }
}
