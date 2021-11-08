import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/screens/screens.dart';
import 'package:trivia_app/services/trivia.dart';

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: QuizChoiceForm());
  }
}

class QuizChoiceForm extends StatefulWidget {
  QuizChoiceForm({Key? key}) : super(key: key);

  @override
  _QuizChoiceFormState createState() => _QuizChoiceFormState();
}

class _QuizChoiceFormState extends State<QuizChoiceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TriviaService triv = Get.find();
  late String? selectedItem;

  void initState() {
    super.initState();
    selectedItem = triv.difficulties[0]['value'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey[800],
      constraints: const BoxConstraints(
        maxWidth: 600,
        minWidth: 300,
      ),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Start Your Quiz'),
            Obx(() => Text('${triv.categoryName}')),
            DropdownButton(
              value: selectedItem,
              onChanged: (val) => setState(() {
                selectedItem = val as String;
              }),
              items: triv.difficulties.map((Map<String, String> difficulty) {
                return DropdownMenuItem(
                  child: Text(
                    '${difficulty['display']}',
                  ),
                  value: difficulty['value'],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
