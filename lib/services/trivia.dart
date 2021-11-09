import 'dart:convert';
import 'dart:math';

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
  var categoryId = 9.obs;
  var categoryName = 'General Knowledge'.obs;
  RxList<QuizQuestion> activeQuiz = <QuizQuestion>[].obs;

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
    } else {
      throw Exception('Could not load quiz');
    }
  }
}

class QuizQuestion {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  QuizQuestion(
      {required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers});

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'].toString(),
      correctAnswer: json['correct_answer'].toString(),
      incorrectAnswers: json['incorrect_answers'].map<String>((ia) {
        return ia.toString();
      }).toList(),
    );
  }

  List<String> allAnswers() {
    int injectedPosition = Random().nextInt(4);
    List<String> answers = incorrectAnswers;

    answers.insert(injectedPosition, correctAnswer);

    return answers;
  }

  bool correct(String ans) {
    return ans == correctAnswer;
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
