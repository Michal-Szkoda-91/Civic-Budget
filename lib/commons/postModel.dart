import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  final String content;
  final String dateTime;
  final String slug;
  final int featuredMedia;

  Post({
    this.id,
    this.title,
    this.content,
    this.dateTime,
    this.slug,
    this.featuredMedia,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      dateTime: json['date'],
      slug: json['slug'],
      featuredMedia: json['featured_media'],
    );
  }
}

class Posts with ChangeNotifier {
  static const baseURL = 'https://www.decyduj.com.pl';

  // Pobieranie kategorii i mapowanie ich ID
  Future<int> fetchCategories(String categoryName) async {
    final categoriesUrl =
        '$baseURL/wp-json/wp/v2/categories?search=' + categoryName;
    final response = await http.get(categoriesUrl);

    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      if (responseJson.length > 0) {
        var categoryId = responseJson[0]['id'];
        return categoryId;
      } else {
        throw Exception('No such category: ' + categoryName);
      }
    } else {
      throw Exception('Failed to fetch category ' + categoryName);
    }
  }

  // Pobieranie kategorii które na stronie umieszczone są jako podstrony
  Future<void> fetchPostByID(String sufixAndID, Function setFunction) async {
    final url = '$baseURL/wp-json/wp/v2/$sufixAndID';
    final response = await http.get(url);
    dynamic value = json.decode(response.body);
    List<Post> helplist = [];
    Map<String, dynamic> map = value;
    helplist.add(Post.fromJson(map));
    setFunction(helplist);
    notifyListeners();
  }

  Future<void> fetchPost(int id, Function setFunction) async {
    final url = '$baseURL/wp-json/wp/v2/posts?categories=' + id.toString();
    final response = await http.get(url);
    List<dynamic> value = new List<dynamic>();
    value = json.decode(response.body);
    List<Post> helplist = [];
    value.forEach((value) {
      Map<String, dynamic> map = value;
      helplist.add(Post.fromJson(map));
    });
    setFunction(helplist);
    notifyListeners();
  }

  // Pobieranie kategorii które na stronie umieszczone są jako podstrony
  Future<void> fetchMediaPostsByID(int id, Function setFunction) async {
    final url = '$baseURL/wp-json/wp/v2/media/${id.toString()}';
    final response = await http.get(url);
    dynamic value = json.decode(response.body);
    List<Post> helplist = [];
    Map<String, dynamic> map = value;
    helplist.add(Post.fromJson(map));
    setFunction(helplist);
    notifyListeners();
  }
}
