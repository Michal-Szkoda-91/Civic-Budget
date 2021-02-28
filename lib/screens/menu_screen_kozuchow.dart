import 'package:budget_app/screens/about_budget_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model_aboutApp.dart';
import 'law_screen.dart';
import 'submit_a_project_screen.dart';
import 'vouting_screen.dart';
import 'about_app_screen.dart';
import 'consultation_screen.dart';
import 'contact_screen.dart';
import 'news_screen.dart';
import 'projects_sceen.dart';
import 'shedule_screen.dart';

class MenuScreenK extends StatelessWidget {
  static const routeName = '/menu_screen_kozuchow';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text('Budżet Obywatelski - Kożuchów'),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: constraints.maxHeight,
                child: GridView(
                  padding: const EdgeInsets.all(25),
                  children: [
                    buildGridButton(
                      context,
                      'Aktualności',
                      'icons_image_menu/ico_aktual.png',
                      NewsScreen(
                        title: 'Aktualności - Kożuchów',
                        fetchDataName: 'aktualności-kożuchów',
                        categoryID:
                            3, // pobranie aktualnosci znajac ID kategorii
                      ),
                    ),
                    buildGridButton(
                      context,
                      'O budżecie',
                      'icons_image_menu/ico_budzet.png',
                      AboutBudgetScreen(
                        setPostSufixAndID: 'pages/61',
                        title: 'O budżecie - Kożuchów',
                      ),
                    ),
                    buildGridButton(
                      context,
                      'Projekty',
                      'icons_image_menu/ico_projekty.png',
                      ProjectScreen(
                        title: 'Projekty - Kożuchów',
                        fetchDataName: 'Projekty Kożuchów',
                      ),
                    ),
                    buildGridButton(
                        context,
                        'Głosowanie',
                        'icons_image_menu/ico_glosuj.png',
                        VoutingScreen(
                          fetchDataName: 'Głosowanie Kożuchów',
                          title: 'Głosowanie - Kożuchów',
                        )),
                    buildGridButton(
                      context,
                      'Zgłoś Projekt',
                      'icons_image_menu/ico_zglosprojekt.png',
                      SubmitAProjectScreen(
                        setPostSufixAndID: 'pages/73',
                        title: 'Zgłoś Projekt - Kożuchów',
                      ),
                    ),
                    buildGridButton(
                      context,
                      'Harmonogram',
                      'icons_image_menu/ico_harmonogram.png',
                      SheduleScreen(
                        title: 'Harmonogram - Kożuchów',
                        fetchDataName: 'Harmonogram Kożuchów',
                      ),
                    ),
                    buildGridButton(
                      context,
                      'Prawo',
                      'icons_image_menu/ico_prawo.png',
                      LawScreen(
                        setPostSufixAndID: 'pages/65',
                        title: 'Prawo Kożuchów',
                      ),
                    ),
                    buildGridButton(
                      context,
                      'Konsultacje',
                      'icons_image_menu/ico_konsultacje.png',
                      ConsultationScreen(
                        title: 'Konsultacje - Kożuchów',
                        setPostSufixAndID: 'pages/82',
                      ),
                    ),
                    buildGridButton(
                      context,
                      'O aplikacji',
                      'icons_image_menu/ico_aplikacja.png',
                      AboutAppScreen(
                        content: Provider.of<ModelAboutApp>(context)
                            .aboutAppKozuchow,
                        title: 'O Aplikacji - Kożuchów',
                      ),
                    ),
                    buildGridButton(
                      context,
                      'Kontakt',
                      'icons_image_menu/ico_kontakt.png',
                      ContactScreen(
                        setPostSufixAndID: 'pages/56',
                        title: 'Kontakt - Kożuchów',
                      ),
                    ),
                  ],
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        MediaQuery.of(context).size.width > 600 ? 250 : 150,
                    childAspectRatio: 2 / 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Card buildGridButton(
      BuildContext context, String title, String iconName, Widget widgets) {
    return Card(
      elevation: 10,
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widgets,
              ));
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.width * 0.20,
                child: Image.asset(
                  iconName,
                  fit: BoxFit.contain,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width > 700 ? 20 : 16,
                      fontWeight: FontWeight.w600),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
