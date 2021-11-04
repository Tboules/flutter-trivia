import 'package:flutter/material.dart';

class QuizCategories extends StatelessWidget {
  const QuizCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text(
          'categories',
        ),
      ),
    );
  }
}
