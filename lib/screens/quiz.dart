import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/services/trivia.dart';

class Quiz extends StatelessWidget {
  Quiz({Key? key}) : super(key: key);
  final TriviaService triv = Get.find();

  @override
  Widget build(BuildContext context) {
    return const Center(child: QuizChoiceForm());
  }
}

class QuizChoiceForm extends StatefulWidget {
  const QuizChoiceForm({Key? key}) : super(key: key);

  @override
  _QuizChoiceFormState createState() => _QuizChoiceFormState();
}

class _QuizChoiceFormState extends State<QuizChoiceForm> {
  TriviaService triv = Get.find();
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = triv.difficulties[0]['value'] as String;
  }

  _onSubmit() async {
    String res = await triv.fetchQuiz(selectedItem);

    if (res == 'success') {
      Get.offAllNamed('/quiz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      color: Colors.grey[800],
      constraints: const BoxConstraints(
        maxWidth: 500,
        minWidth: 300,
      ),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(
                'Start Your Quiz',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
            _catFormInput(),
            _difFormInput(),
            _submitButton()
          ],
        ),
      ),
    );
  }

  Widget _catFormInput() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'chosen category:',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Obx(
            () => Text('${triv.categoryName}'),
          ),
        ],
      ),
    );
  }

  Widget _difFormInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'chosen difficulty:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: DropdownButton(
            isExpanded: true,
            value: selectedItem,
            onChanged: (val) => setState(() {
              selectedItem = val as String;
            }),
            items: triv.difficulties.map((Map<String, String> difficulty) {
              return DropdownMenuItem(
                child: Text('${difficulty['display']}'),
                value: difficulty['value'],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _submitButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 40),
          primary: Colors.grey[850],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
        ),
        onPressed: () => _onSubmit(),
        child: const Text('Start!'),
      ),
    );
  }
}
