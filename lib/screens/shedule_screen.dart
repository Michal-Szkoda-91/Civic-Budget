import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../models/model_shedule.dart';
import '../start_screen/bottom_arrow.dart';
import '../start_screen/bottom_logo.dart';
import '../commons/postModel.dart';

class SheduleScreen extends StatefulWidget {
  final String title;
  final String fetchDataName;

  const SheduleScreen({Key key, this.title, this.fetchDataName})
      : super(key: key);

  @override
  _SheduleScreenState createState() => _SheduleScreenState();
}

class _SheduleScreenState extends State<SheduleScreen> {
  List<String> _yearsList = [DateTime.now().year.toString()];
  String _selectedYear = DateTime.now().year.toString();
  List<ModelShedule> _sheduleItemList = [];
  var _isLoaded = false;
  var _isInit = true;
  ScrollController _rrectController = ScrollController();

  //uniwersalna funkcja w ktorej parametrami sa funkcje z przyszlosci ladujace dane z serwera
  Future<void> _loadData(BuildContext context, Function firstMethod,
      Function secondMethod, String categoryName, Function setFunction) async {
    try {
      await firstMethod(await secondMethod(categoryName), setFunction)
          .then((_) {
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

  List<ModelShedule> _newSheduleListSortedByYear = [];
  void _createList(List<ModelShedule> list, int year) {
    _newSheduleListSortedByYear.clear();
    list.forEach((element) {
      if (element.realizationYear == year)
        _newSheduleListSortedByYear.add(element);
    });
  }

  void createYearList(List<ModelShedule> list) {
    list.forEach((element) {
      if (!_yearsList.contains(element.realizationYear.toString())) {
        _yearsList.add(element.realizationYear.toString());
      }
    });
    _yearsList.sort();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final providerData = Provider.of<Posts>(context);
      final providerShedule = Provider.of<ModelSheduleList>(context);
      _loadData(context, providerData.fetchPost, providerData.fetchCategories,
              widget.fetchDataName, providerShedule.setPostsShedule)
          .then((value) {
        providerShedule.fetchShedule();
        _sheduleItemList = providerShedule.sheduleModel;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _createList(_sheduleItemList, int.parse(_selectedYear));
    //utworzenie listy lat zawierajacych projekty
    createYearList(_sheduleItemList);
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
                    background: Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              buildCustomDropDownButton(context, constraints),
                              buildCustomContent(constraints, context),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  Container buildCustomContent(
      BoxConstraints constraints, BuildContext context) {
    return Container(
      height: constraints.maxHeight < 600
          ? constraints.maxHeight * 0.83
          : constraints.maxHeight * 0.90,
      child: DraggableScrollbar.rrect(
        controller: _rrectController,
        heightScrollThumb: 100,
        backgroundColor: Theme.of(context).accentColor,
        padding: EdgeInsets.all(5),
        child: _newSheduleListSortedByYear.length == 0
            ? Center(
                child: Text('Brak Harmonogramu dla wybranego roku'),
              )
            : ListView.builder(
                controller: _rrectController,
                itemCount: _newSheduleListSortedByYear.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 20),
                    child: Html(
                      data: _newSheduleListSortedByYear[index].description,
                    ),
                  );
                },
              ),
      ),
    );
  }

  Container buildCustomDropDownButton(
      BuildContext context, BoxConstraints constraints) {
    return Container(
      color: Theme.of(context).accentColor,
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      height: constraints.maxHeight < 650
          ? constraints.maxHeight * 0.10
          : constraints.maxHeight * 0.05,
      child: DropdownButton<String>(
        value: _selectedYear,
        isExpanded: true,
        underline: Container(),
        icon: Icon(
          Icons.arrow_downward,
          color: Theme.of(context).primaryColor,
        ),
        iconSize: 30,
        elevation: 8,
        style: TextStyle(color: Colors.black, fontSize: 24),
        onChanged: (String newValue) {
          setState(() {
            _selectedYear = newValue;
          });
        },
        items: _yearsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              alignment: Alignment.center,
              color: Theme.of(context).accentColor,
              child: FittedBox(
                child: Text(
                  value + 'r.',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
