import 'package:flutter/material.dart';

import '../commons/postModel.dart';

class ModelShedule {
  final String description;
  final int realizationYear;

  ModelShedule({
    @required this.description,
    @required this.realizationYear,
  });
}

class ModelSheduleList with ChangeNotifier {
  List<ModelShedule> _sheduleModel = [];
  List<ModelShedule> get sheduleModel {
    return [..._sheduleModel];
  }

  //Lista Projektow -posty
  List<Post> _postsShedule = [];

  void setPostsShedule(List<Post> list) {
    _postsShedule = list;
  }

//metoda pobierajaca dane z danego wybranego roku
  void fetchShedule() {
    List<ModelShedule> helpList = [];
    _postsShedule.forEach((element) {
      helpList.add(new ModelShedule(
          description: element.content,
          //tymczasowe pobieranie roku
          realizationYear: int.parse(element.slug.substring(0, 4))));
    });
    _sheduleModel = helpList;
    notifyListeners();
  }
}
