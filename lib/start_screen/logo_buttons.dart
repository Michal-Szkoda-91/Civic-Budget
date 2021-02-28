import 'package:flutter/material.dart';

import '../screens/menu_screen_otyn.dart';
import '../screens/menu_screen_kozuchow.dart';

class LogoButtons extends StatelessWidget {
  const LogoButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.50,
              height: MediaQuery.of(context).size.width * 0.1,
              child: FittedBox(
                child: Text(
                  'Gmina Kożuchów',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Ink.image(
                image: AssetImage('images/herb_kozuchow.png'),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(MenuScreenK.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.1,
              child: FittedBox(
                child: Text(
                  'Gmina Otyń',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Ink.image(
                image: AssetImage('images/herb_otyn.png'),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(MenuScreenOtyn.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
