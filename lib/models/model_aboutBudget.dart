import 'package:flutter/cupertino.dart';

import '../commons/postModel.dart';

class ModelBudget with ChangeNotifier {
  //metoda pobierajaca prawo dla ia
  String _budget = '';
  String get budget {
    return _budget;
  }

  //Lista Prawo  - posty
  List<Post> _postsBudget = [];

  void setpostsBudget(List<Post> list) {
    _postsBudget = list;
  }

  Future<void> fetchBudget() async {
    String helpString = '';
    _postsBudget.forEach((element) {
      helpString = element.content;
    });
    _budget = helpString;
    notifyListeners();
  }
}
