import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trivia_app/screens/screens.dart';
import 'package:trivia_app/services/trivia.dart';

class QuizQuestions extends StatelessWidget {
  QuizQuestions({Key? key}) : super(key: key);
  final TriviaService triv = Get.find();

  void _quitQuiz() {
    triv.resetQuiz();
    Get.offAllNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _quizBar(context),
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: Center(
              child: ElevatedButton(
                onPressed: _quitQuiz,
                child: const Text("reset quiz"),
              ),
            ),
          ),
          width > 1024
              ? const Expanded(
                  flex: 3,
                  child: UserData(),
                )
              : Container()
        ],
      ),
    );
  }

  PreferredSizeWidget _quizBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AppBar(
      title: const Text(
        'quiz',
      ),
      leading: IconButton(
        onPressed: _quitQuiz,
        icon: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: Colors.white,
        ),
      ),
      actions: width > 1024
          ? []
          : [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: GestureDetector(
                  child: const Icon(
                    FontAwesomeIcons.user,
                    color: Colors.white70,
                  ),
                  onTap: () => Get.toNamed('/user'),
                ),
              )
            ],
    );
  }
}
