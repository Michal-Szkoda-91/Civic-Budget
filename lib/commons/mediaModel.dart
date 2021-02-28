import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PostMedia {
  final int id;
  final String guid;

  PostMedia({
    this.id,
    this.guid,
  });

  factory PostMedia.fromJson(Map<String, dynamic> json) {
    return PostMedia(
      id: json['id'],
      guid: json['guid']['rendered'],
    );
  }
}

class MediaPostList with ChangeNotifier {
  static const baseURL = 'https://www.decyduj.com.pl';

  PostMedia postMedia;
  PostMedia get postMediaData {
    return postMedia;
  }

  void setpostsMedia(PostMedia post) {
    postMedia = post;
  }

  // Pobieranie zdjecia
  Future<void> fetchMediaPostsByID(int id) async {
    final url = '$baseURL/wp-json/wp/v2/media/${id.toString()}';
    final response = await http.get(url);
    dynamic value = json.decode(response.body);
    Map<String, dynamic> map = value;
    postMedia = (PostMedia.fromJson(map));
    setpostsMedia(postMedia);
  }
}
