import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/services/auth.dart';
import 'package:trivia_app/services/services.dart';
import 'package:trivia_app/shared/loading.dart';

class UserData extends StatelessWidget {
  UserData({Key? key}) : super(key: key);
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool bigScreen = width > 1024;

    return Container(
      margin: EdgeInsets.all(bigScreen ? 10 : 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bigScreen ? Colors.grey[800] : null,
        borderRadius: BorderRadius.circular(bigScreen ? 4 : 0),
      ),
      child: Column(
        children: [
          QuizReportList(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              primary: Colors.grey[width > 1024 ? 850 : 800],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
            onPressed: () {
              auth.signOut();
              Get.offAllNamed('/');
            },
            child: const Text(
              'Sign Out',
            ),
          )
        ],
      ),
    );
  }
}

class QuizReportList extends StatefulWidget {
  QuizReportList({Key? key}) : super(key: key);

  @override
  _QuizReportListState createState() => _QuizReportListState();
}

class _QuizReportListState extends State<QuizReportList> {
  QuizReportsService qr = QuizReportsService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: qr.getUserQuizHistory(),
      builder: (context, AsyncSnapshot<Iterable<QuizReport>> snapshot) {
        if (!snapshot.hasData) {
          return const Expanded(
            child: Center(
              child: LoadingIndicator(),
            ),
          );
        }
        return Expanded(
            child: ListView(
          children: snapshot.data!.map((quizR) {
            return Card(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 4,
                bottom: 4,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                hoverColor: Colors.grey[700],
                tileColor: Colors.grey[850],
                title: Text(quizR.quizCategory),
                subtitle: Text('${quizR.correctAnswers} / 10'),
              ),
            );
          }).toList(),
        ));
      },
    );
  }
}
