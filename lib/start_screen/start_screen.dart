import 'dart:io';

import 'package:flutter/material.dart';

import 'bottom_logo.dart';
import 'custom_AppBar.dart';
import 'logo_buttons.dart';

class StartScreen extends StatelessWidget {
  static const nameRoute = '/start-screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Budżet Obywatelski'),
          actions: [
            FlatButton(
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => _showDialog(context),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(),
            Spacer(),
            LogoButtons(),
            Spacer(),
            BottomLogo(),
          ],
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Czy na pewno chcesz zamknąć aplikacje?"),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Zamknij',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () => exit(0),
                ),
                FlatButton(
                  child: Text(
                    'Anuluj',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
