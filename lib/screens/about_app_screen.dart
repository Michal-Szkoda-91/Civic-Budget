import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../start_screen/bottom_arrow.dart';
import '../start_screen/bottom_logo.dart';

class AboutAppScreen extends StatefulWidget {
  final String content;
  final String title;

  const AboutAppScreen({Key key, this.content, this.title}) : super(key: key);

  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  ScrollController _rrectController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ExpandableBottomSheet(
              background: buildCustomContent(constraints, widget.content),
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

  Container buildCustomContent(BoxConstraints constraints, String content) {
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
            Padding(padding: const EdgeInsets.all(15.0), child: Text(content)),
          ],
        ),
      ),
    );
  }
}
