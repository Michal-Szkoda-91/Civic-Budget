import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../start_screen/bottom_arrow.dart';
import '../start_screen/bottom_logo.dart';
import '../models/model_submit_project.dart';
import '../commons/postModel.dart';

class SubmitAProjectScreen extends StatefulWidget {
  final String setPostSufixAndID;
  final String title;

  const SubmitAProjectScreen({Key key, this.setPostSufixAndID, this.title})
      : super(key: key);

  @override
  _SubmitAProjectScreenState createState() => _SubmitAProjectScreenState();
}

class _SubmitAProjectScreenState extends State<SubmitAProjectScreen> {
  String _submittItem = '';
  var _isLoaded = false;
  var _isInit = true;
  ScrollController _rrectController = ScrollController();

  //uniwersalna funkcja w ktorej parametrami sa funkcje z przyszlosci ladujace dane z serwera
  Future<void> _loadData(BuildContext context, Function firstMethod,
      String sufixAndID, Function setFunction) async {
    try {
      await firstMethod(sufixAndID, setFunction).then((_) {
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

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final providerData = Provider.of<Posts>(context);
      final providerSubmitt = Provider.of<ModelSubmitt>(context);
      _loadData(context, providerData.fetchPostByID, widget.setPostSufixAndID,
              providerSubmitt.setpostssubmitt)
          .then((value) {
        providerSubmitt.fetchsubmitt();
        _submittItem = providerSubmitt.submitt;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Html(
                data: _submittItem,
                onLinkTap: (url) {
                  launch(url);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
