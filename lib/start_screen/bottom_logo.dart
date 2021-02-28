import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomLogo extends StatelessWidget {
  const BottomLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: mediaQuery * 0.30,
                height: mediaQuery * 0.25,
                child: GestureDetector(
                  onTap: () {
                    launch('http://www.niw.gov.pl');
                  },
                  child: Image.asset(
                    'images/logo_niw_kolor_podst.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                width: mediaQuery * 0.35,
                height: mediaQuery * 0.25,
                child: GestureDetector(
                  onTap: () {
                    launch('https://niw.gov.pl/nasze-programy/proo/');
                  },
                  child: Image.asset(
                    'images/logo_PROO.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: FittedBox(
            child: Text(
              'Sfinansowano przez Narodowy Instytut Wolności \n- Centrum Rozwoju Społeczeństwa Obywatelskiego \nze środków Programu Rozwoju Organizacji Obywatelskich \nna lata 2018 – 2030',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
