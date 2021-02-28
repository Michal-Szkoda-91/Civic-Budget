import 'package:flutter/cupertino.dart';

import '../commons/postModel.dart';

class ModelSubmitt with ChangeNotifier {
  //metoda pobierajaca prawo dla
  String _submitt = '';
  String get submitt {
    return _submitt;
  }

  //Lista Prawo  - posty
  List<Post> _postssubmitt = [];

  void setpostssubmitt(List<Post> list) {
    _postssubmitt = list;
  }

  Future<void> fetchsubmitt() async {
    String helpString = '';
    _postssubmitt.forEach((element) {
      helpString = element.content;
    });
    _submitt = helpString;
    notifyListeners();
  }
}
