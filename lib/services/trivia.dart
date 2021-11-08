import 'dart:convert';

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

  void setCategory(Category cat) {
    categoryId.value = cat.id;
    categoryName.value = cat.name;
    // update();
    print(categoryName);
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
      throw Exception('Failed to load album');
    }
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
