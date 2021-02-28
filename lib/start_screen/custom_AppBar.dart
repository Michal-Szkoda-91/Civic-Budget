import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.width * 0.30,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
        ),
        child: Image.asset(
          'images/logo_main_page.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
