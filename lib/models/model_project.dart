import 'package:flutter/material.dart';

import '../commons/postModel.dart';

class ProjectModel {
  final String title;
  final String description;
  final int realizationYear;

  ProjectModel({
    @required this.title,
    @required this.description,
    @required this.realizationYear,
  });
}

class ModelProjectList with ChangeNotifier {
  //metoda pobierajaca projekty dla ia
  List<ProjectModel> _projectList = [];

  List<ProjectModel> get projectList {
    return [..._projectList];
  }

  //Lista Projektow -posty
  List<Post> _postsProject = [];

  void setPostsProject(List<Post> list) {
    _postsProject = list;
  }

  void fetchProject() {
    List<ProjectModel> helpList = [];
    _postsProject.forEach((element) {
      helpList.add(new ProjectModel(
        title: element.title,
        description: element.content,
        //wiem, wyglada paskudnie, ale narazie tylko tak moge dostac sie do roku projektu a jest to niezbedne
        realizationYear: int.parse(
            element.content.split('Rok realizacji: ')[1].substring(0, 4)),
      ));
    });
    _projectList = helpList;
    notifyListeners();
  }
}
