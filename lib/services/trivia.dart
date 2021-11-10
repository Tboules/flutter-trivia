import 'dart:convert';
import 'dart:math';
import 'package:html_unescape/html_unescape.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TriviaService extends GetxController {
  List<Map<String, String>> difficulties = [
    {'display': 'Select a Difficulty', 'value': ''},
    {'display': 'Easy', 'value': 'easy'},
    {'display': 'Medium', 'value': 'medium'},
    {'display': 'Hard', 'value': 'hard'},
  ];
  RxInt categoryId = 9.obs;
  RxString categoryName = 'General Knowledge'.obs;
  RxList<QuizQuestion> activeQuiz = <QuizQuestion>[].obs;
  RxInt correctAnswers = 0.obs;

  void setCorrectAnswers() {
    correctAnswers++;
    print(correctAnswers);
  }

  void setCategory(Category cat) {
    categoryId.value = cat.id;
    categoryName.value = cat.name;
  }

  void resetQuiz() {
    activeQuiz.value = [];
  }

  Future<List<Category>> fetchCategories() async {
    String uri = 'https://opentdb.com/api_category.php';
    var res = await http.get(Uri.parse(uri));

    if (res.statusCode == 200) {
      List<dynamic> catArr = jsonDecode(res.body)['trivia_categories'];
      return catArr.map((item) {
        return Category.fromJson(item);
      }).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<dynamic> fetchQuiz(String dif) async {
    String link =
        "https://opentdb.com/api.php?amount=10&category=$categoryId&difficulty=$dif&type=multiple";
    var res = await http.get(Uri.parse(link));

    if (res.statusCode == 200) {
      var quizArr = jsonDecode(res.body)['results'];
      activeQuiz.value = quizArr.map<QuizQuestion>((question) {
        return QuizQuestion.fromJson(question);
      }).toList();
      return 'success';
    } else {
      throw Exception('Could not load quiz');
    }
  }
}

class QuizQuestion extends GetxController {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  late List<String> answers;
  final RxBool answered = false.obs;

  QuizQuestion(
      {required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers}) {
    answers = _allAnswers();
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    var unescape = HtmlUnescape();

    return QuizQuestion(
      question: unescape.convert(json['question']),
      correctAnswer: unescape.convert(json['correct_answer']),
      incorrectAnswers: json['incorrect_answers'].map<String>((ia) {
        return unescape.convert(ia.toString());
      }).toList(),
    );
  }

  List<String> _allAnswers() {
    int injectedPosition = Random().nextInt(4);
    List<String> answers = incorrectAnswers;

    answers.insert(injectedPosition, correctAnswer);

    return answers;
  }

  bool correct(String ans) {
    return ans == correctAnswer;
  }

  void setAnswered() {
    answered.value = true;
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
