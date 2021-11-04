import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TriviaService extends GetxController {
  var categoryId = 1.obs;

  void setCategory(RxInt catId) {
    categoryId = catId;
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
