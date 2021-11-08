import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/services/trivia.dart';
import 'package:trivia_app/shared/loading.dart';

class QuizCategories extends StatefulWidget {
  const QuizCategories({Key? key}) : super(key: key);

  @override
  State<QuizCategories> createState() => _QuizCategoriesState();
}

class _QuizCategoriesState extends State<QuizCategories> {
  TriviaService triv = Get.find();
  late Future<List<Category>> categories;

  @override
  void initState() {
    categories = triv.fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(width > 1024 ? 10 : 0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(
          width > 1024 ? 4 : 0,
        ),
      ),
      child: FutureBuilder<List>(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Choose a Category',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: snapshot.data!.map((cat) {
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
                          title: Text(
                            '${cat.name}',
                          ),
                          onTap: () => triv.setCategory(cat),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          } else {
            return const LoadingIndicator();
          }
        },
      ),
    );
  }
}
