import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/services/trivia.dart';

class Quiz extends StatelessWidget {
  TriviaService triv = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => Text('${triv.categoryId}'),
      ),
    );
  }
}
