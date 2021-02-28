import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model_aboutApp.dart';
import 'law_screen.dart';
import 'projects_sceen.dart';
import 'about_app_screen.dart';
import 'consultation_screen.dart';
import 'contact_screen.dart';
import 'news_screen.dart';
import 'shedule_screen.dart';
import 'submit_a_project_screen.dart';
import 'vouting_screen.dart';
import 'about_budget_screen.dart';

class MenuScreenOtyn extends StatelessWidget {
  static const routeName = '/menu_screen_Otyn';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: FittedBox(
            child: Text('Budżet Obywatelski - Otyń'),
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
                          title: 'Aktualności - Otyń',
                          fetchDataName: 'aktualności-otyń',
                          categoryID:
                              1, // pobranie aktualnosci znajac ID kategorii
                        ),
                      ),
                      buildGridButton(
                          context,
                          'O budżecie',
                          'icons_image_menu/ico_budzet.png',
                          AboutBudgetScreen(
                            setPostSufixAndID: 'pages/21',
                            title: 'O budżecie - Otyń',
                          )),
                      buildGridButton(
                        context,
                        'Projekty',
                        'icons_image_menu/ico_projekty.png',
                        ProjectScreen(
                          title: 'Projekty - Otyń',
                          fetchDataName: 'Projekty Otyń',
                        ),
                      ),
                      buildGridButton(
                        context,
                        'Głosowanie',
                        'icons_image_menu/ico_glosuj.png',
                        VoutingScreen(
                          fetchDataName: 'Głosowanie Otyń',
                          title: 'Głosowanie - Otyń',
                        ),
                      ),
                      buildGridButton(
                        context,
                        'Zgłoś Projekt',
                        'icons_image_menu/ico_zglosprojekt.png',
                        SubmitAProjectScreen(
                          setPostSufixAndID: 'pages/30',
                          title: 'Zgłoś Projekt - Otyń',
                        ),
                      ),
                      buildGridButton(
                        context,
                        'Harmonogram',
                        'icons_image_menu/ico_harmonogram.png',
                        SheduleScreen(
                          title: 'Harmonogram - Otyń',
                          fetchDataName: 'Harmonogram Otyń',
                        ),
                      ),
                      buildGridButton(
                        context,
                        'Prawo',
                        'icons_image_menu/ico_prawo.png',
                        LawScreen(
                          setPostSufixAndID: 'pages/19',
                          title: 'Prawo - Otyń',
                        ),
                      ),
                      buildGridButton(
                        context,
                        'Konsultacje',
                        'icons_image_menu/ico_konsultacje.png',
                        ConsultationScreen(
                          title: 'Konsultacje - Otyń',
                          setPostSufixAndID: 'pages/40',
                        ),
                      ),
                      buildGridButton(
                        context,
                        'O aplikacji',
                        'icons_image_menu/ico_aplikacja.png',
                        AboutAppScreen(
                          content: Provider.of<ModelAboutApp>(context)
                              .aboutAppKozuchow,
                          title: 'O Aplikacji - Otyń',
                        ),
                      ),
                      buildGridButton(
                        context,
                        'Kontakt',
                        'icons_image_menu/ico_kontakt.png',
                        ContactScreen(
                          setPostSufixAndID: 'pages/56',
                          title: 'Kontakt - Otyń',
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
      ),
    );
  }

  Card buildGridButton(
      BuildContext context, String titleGrid, String iconName, Widget widgets) {
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
                  titleGrid,
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
