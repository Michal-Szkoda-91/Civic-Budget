import 'package:flutter/material.dart';

import '../commons/postModel.dart';

class ModelContact with ChangeNotifier {
  //metoda pobierajaca prawo dla Otynia
  String _contact = '';
  String get contact {
    return _contact;
  }

  //Lista Prawo Otyn - posty
  List<Post> _postsContact = [];

  void setpostsContact(List<Post> list) {
    _postsContact = list;
  }

  Future<void> fetchContact() async {
    String helpString = '';
    _postsContact.forEach((element) {
      helpString = element.content;
    });
    _contact = helpString;
    notifyListeners();
  }
}
