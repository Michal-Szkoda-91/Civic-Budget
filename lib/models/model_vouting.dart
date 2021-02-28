import 'package:flutter/material.dart';

import '../commons/postModel.dart';

class ModelVouting {
  final String description;
  final int realizationYear;

  ModelVouting({
    @required this.description,
    @required this.realizationYear,
  });
}

class ModelVoutingList with ChangeNotifier {
  List<ModelVouting> _voutingModel = [];
  List<ModelVouting> get voutingModel {
    return [..._voutingModel];
  }

  //Lista Projektow -posty
  List<Post> _postsVouting = [];

  void setPostsVouting(List<Post> list) {
    _postsVouting = list;
  }

//metoda pobierajaca dane z danego wybranego roku
  void fetchVouting() {
    List<ModelVouting> helpList = [];
    _postsVouting.forEach((element) {
      helpList.add(new ModelVouting(
          description: element.content,
          //tymczasowe pobieranie roku
          realizationYear: int.parse(element.slug.split('-')[3])));
    });
    _voutingModel = helpList;
    notifyListeners();
  }
}
