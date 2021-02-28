import 'package:flutter/material.dart';

import '../commons/postModel.dart';

class ModelLaw with ChangeNotifier {
  //metoda pobierajaca prawo dla Otynia
  String _law = '';
  String get law {
    return _law;
  }

  //Lista Prawo Otyn - posty
  List<Post> _postsLaw = [];

  void setpostsLaw(List<Post> list) {
    _postsLaw = list;
  }

  Future<void> fetchLaw() async {
    String helpString = '';
    _postsLaw.forEach((element) {
      helpString = element.content;
    });
    _law = helpString;
    notifyListeners();
  }
}
