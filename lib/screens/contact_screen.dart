import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../commons/postModel.dart';
import '../models/model_Contact.dart';
import '../start_screen/bottom_logo.dart';

class ContactScreen extends StatefulWidget {
  final String setPostSufixAndID;
  final String title;

  const ContactScreen({Key key, this.setPostSufixAndID, this.title})
      : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  String _contactItem = '';
  var _isLoaded = false;
  var _isInit = true;

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
      final providerLaw = Provider.of<ModelContact>(context);
      _loadData(context, providerData.fetchPostByID, widget.setPostSufixAndID,
              providerLaw.setpostsContact)
          .then((value) {
        providerLaw.fetchContact();
        _contactItem = providerLaw.contact;
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
                  return Column(
                    children: [
                      Container(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Html(
                              data: _contactItem,
                              onLinkTap: (url) {
                                launch(url);
                              },
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      BottomLogo(),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
