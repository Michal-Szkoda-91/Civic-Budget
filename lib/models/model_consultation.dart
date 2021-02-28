import 'package:flutter/material.dart';

import '../commons/postModel.dart';

class ModelConsultation with ChangeNotifier {
  //metoda pobierajaca prawo dla Otynia
  String _consultation = '';
  String get consultation {
    return _consultation;
  }

  //Lista Prawo Otyn - posty
  List<Post> _postsConsultation = [];

  void setpostsConsultation(List<Post> list) {
    _postsConsultation = list;
  }

  Future<void> fetchConsultation() async {
    String helpString = '';
    _postsConsultation.forEach((element) {
      helpString = element.content;
    });
    _consultation = helpString;
    notifyListeners();
  }
}
