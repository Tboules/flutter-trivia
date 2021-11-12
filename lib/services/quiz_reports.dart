import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:trivia_app/screens/screens.dart';

class QuizReportsService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserQuizData(String cat, int cor) {
    User? user = _auth.currentUser;
    DocumentReference docRef = _db.collection('reports').doc(user?.uid);

    if (user?.uid != null) {
      return docRef.collection('quiz_reports').add({
        'taken': DateTime.now(),
        'quiz_category': cat,
        'correct_answers': cor,
      });
    }

    return docRef.get();
  }

  Stream<Iterable<QuizReport>>? getUserQuizHistory() {
    User? user = _auth.currentUser;
    if (user?.uid != null) {
      CollectionReference colRef =
          _db.collection('reports').doc(user!.uid).collection('quiz_reports');

      return colRef.snapshots().map((l) {
        return l.docs.map(
          (v) => QuizReport.fromMap(v.data()! as Map<String, dynamic>),
        );
      });
    }
  }
}

class QuizReport {
  int correctAnswers;
  String quizCategory;
  Timestamp dateTaken;

  QuizReport(
      {required this.correctAnswers,
      required this.quizCategory,
      required this.dateTaken});

  factory QuizReport.fromMap(Map data) {
    return QuizReport(
      correctAnswers: data['correct_answers'] ?? 0,
      quizCategory: data['quiz_category'] ?? '',
      dateTaken: data['taken'] ?? '',
    );
  }
}
