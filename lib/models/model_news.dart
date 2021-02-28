import 'package:flutter/cupertino.dart';

import '../commons/postModel.dart';

class ModelNews {
  final String title;
  final String description;
  final String content;
  final DateTime addingDate;
  bool isExpanded;
  final int featuredMedia;

  ModelNews({
    this.addingDate,
    this.title,
    this.description,
    this.content,
    this.isExpanded,
    this.featuredMedia,
  });
}

class ModelNewsList with ChangeNotifier {
  //metoda pobierajaca aktualnosci dla ia
  List<ModelNews> _newsList = [];

  List<ModelNews> get newsList {
    return [..._newsList];
  }

  //Lista Aktualnosci - posty
  List<Post> _postsNews = [];

  void setpostsNews(List<Post> list) {
    _postsNews = list;
  }

  void newsListSortedByDate() {
    List<ModelNews> helplist = [];
    _postsNews.forEach((element) {
      helplist.add(new ModelNews(
        title: element.title,
        description: 'Zobacz więcej...',
        content: element.content,
        addingDate: DateTime.parse(element.dateTime),
        isExpanded: false,
        featuredMedia: element.featuredMedia,
      ));
    });
    _newsList = helplist;
    //Sortowanie wg daty - najmlodsze wyswietlane sa na jako pierwsze
    _newsList.sort((b, a) {
      return a.addingDate.compareTo(b.addingDate);
    });
    notifyListeners();
  }
}
