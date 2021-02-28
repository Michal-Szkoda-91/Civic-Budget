import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/model_news.dart';
import '../start_screen/bottom_logo.dart';
import '../start_screen/bottom_arrow.dart';
import '../commons/postModel.dart';
import '../commons/mediaModel.dart';

class NewsScreen extends StatefulWidget {
  final String title;
  final String fetchDataName;
  final int categoryID;

  const NewsScreen({Key key, this.title, this.fetchDataName, this.categoryID})
      : super(key: key);
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<ModelNews> _newsItemList = [];
  bool _isListReady = false;
  var _isLoaded = false;
  var _imageIsLoaded = false;
  var _isInit = true;
  ScrollController _rrectController = ScrollController();
  Map<int, String> src = {};

//uniwersalna funkcja w ktorej parametrami sa funkcje z przyszlosci ladujace dane z serwera
  Future<void> _loadData(
      BuildContext context,
      Function firstMethod,
      Function secondMethod,
      String categoryName,
      Function setFunction,
      int categoryID) async {
    try {
      await firstMethod(categoryID, setFunction).then((_) {
        setState(() {
          _isLoaded = true;
        });
      });
    } catch (error) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Nie udało się wczytać danych!'),
          content: Text(
              'Sprawdź połączenie z internetem.\nJeśli połączenie jest prawidłowe spróbuj ponownie później.'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }

  Future<void> _loadMedia(int id) async {
    if (!_imageIsLoaded) {
      try {
        final providerMedia = Provider.of<MediaPostList>(context);
        providerMedia.fetchMediaPostsByID(id).then((_) {
          setState(() {
            src[id] = providerMedia.postMedia.guid;
            _imageIsLoaded = true;
          });
        });
      } catch (error) {
        print('Error occured');
        //zastepczy obrazek
        src[id] =
            'https://www.decyduj.com.pl/wp-content/uploads/2020/12/decyduj-logo-500.png';
      }
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final providerData = Provider.of<Posts>(context);
      final providerNews = Provider.of<ModelNewsList>(context);
      _loadData(
        context,
        providerData.fetchPost,
        providerData.fetchCategories,
        widget.fetchDataName,
        providerNews.setpostsNews,
        widget.categoryID,
      ).then((value) {
        providerNews.newsListSortedByDate();
        _createList(providerNews.newsList);
        _isListReady = true;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _createList(List<ModelNews> list) {
    if (!_isListReady) {
      list.forEach((element) {
        _newsItemList.add(element);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: !_isLoaded
            ? Center(
                child: CircularProgressIndicator(),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  return ExpandableBottomSheet(
                    background: buildCustomContent(constraints),
                    persistentHeader: BottomArrow(
                      constraints: constraints,
                    ),
                    expandableContent: Container(
                      color: Theme.of(context).backgroundColor,
                      child: BottomLogo(),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Container buildCustomContent(BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight < 600
          ? constraints.maxHeight * 0.93
          : constraints.maxHeight * 0.95,
      child: DraggableScrollbar.rrect(
        controller: _rrectController,
        heightScrollThumb: 100,
        backgroundColor: Theme.of(context).accentColor,
        padding: EdgeInsets.all(5),
        child: ListView(
          controller: _rrectController,
          children: [
            Card(
              child: ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.all(20),
                elevation: 4,
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    _newsItemList[panelIndex].isExpanded = !isExpanded;
                  });
                },
                children: _newsItemList.map<ExpansionPanel>(
                  (item) {
                    return ExpansionPanel(
                      headerBuilder: (context, isExpanded) {
                        if (_isListReady) _loadMedia(item.featuredMedia);
                        return HeaderBuilder(
                          item: item,
                          opacity: isExpanded ? 0.0 : 1.0,
                        );
                      },
                      body: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Column(
                          children: [
                            src[item.featuredMedia] != null
                                ? Image.network(src[item.featuredMedia])
                                : Container(),
                            Html(
                              data: item.content,
                              onLinkTap: (url) {
                                launch(url);
                              },
                            ),
                          ],
                        ),
                      ),
                      isExpanded: item.isExpanded,
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderBuilder extends StatelessWidget {
  final ModelNews item;
  final dynamic opacity;
  HeaderBuilder({
    this.item,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Opacity(
            opacity: opacity,
            child: Html(
              data: item.description,
            ),
          ),
        ],
      ),
    );
  }
}
