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
            child: _quiz(),
          ),
          width > 1024
              ? Expanded(
                  flex: 3,
                  child: UserData(),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _quiz() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListView(
        children: triv.activeQuiz.map((question) {
          //do some business logic here

          return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                ...question.answers.map((ans) {
                  return AnswerOption(answer: ans, question: question);
                }).toList()
              ],
            ),
          );
        }).toList(),
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

class AnswerOption extends StatefulWidget {
  String answer;
  QuizQuestion question;
  AnswerOption({Key? key, required this.answer, required this.question})
      : super(key: key);

  @override
  _AnswerOptionState createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    bool correct = widget.question.correct(widget.answer);

    Color? determineColor() {
      if (correct) {
        return Colors.green;
      } else if (clicked && !correct) {
        return Colors.red;
      } else {
        return Colors.grey[700];
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Obx(
        () => TextButton(
          style: TextButton.styleFrom(
            maximumSize: const Size(500, 50),
            primary: Colors.white,
            backgroundColor: widget.question.answered.value
                ? determineColor()
                : Colors.grey[700],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.answer,
              textAlign: TextAlign.left,
            ),
          ),
          onPressed: () {
            if (widget.question.answered.value) return;
            widget.question.setAnswered();
            setState(() {
              clicked = !clicked;
            });
          },
        ),
      ),
    );
  }
}
