import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/model_vouting.dart';
import 'start_screen/start_screen.dart';
import 'commons/mediaModel.dart';
import 'commons/postModel.dart';

import 'models/model_consultation.dart';
import 'models/model_Contact.dart';
import 'models/model_law.dart';
import 'models/model_aboutApp.dart';
import 'models/model_submit_project.dart';
import 'models/model_aboutBudget.dart';
import 'models/model_project.dart';
import 'models/model_news.dart';
import 'models/model_shedule.dart';

import 'screens/menu_screen_kozuchow.dart';
import 'screens/menu_screen_otyn.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Posts()),
        ChangeNotifierProvider(create: (_) => MediaPostList()),
        ChangeNotifierProvider(create: (_) => ModelLaw()),
        ChangeNotifierProvider(create: (_) => ModelBudget()),
        ChangeNotifierProvider(create: (_) => ModelSubmitt()),
        ChangeNotifierProvider(create: (_) => ModelVoutingList()),
        ChangeNotifierProvider(create: (_) => ModelAboutApp()),
        ChangeNotifierProvider(create: (_) => ModelConsultation()),
        ChangeNotifierProvider(create: (_) => ModelNewsList()),
        ChangeNotifierProvider(create: (_) => ModelSheduleList()),
        ChangeNotifierProvider(create: (_) => ModelProjectList()),
        ChangeNotifierProvider(create: (_) => ModelContact()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Budżet Obywatelski',
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          accentColor: Colors.yellow[600],
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline2: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline3: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        routes: {
          //2 podstawowe strony w menu glownym
          StartScreen.nameRoute: (ctx) => StartScreen(),
          MenuScreenK.routeName: (ctx) => MenuScreenK(),
          MenuScreenOtyn.routeName: (ctx) => MenuScreenOtyn(),
        },
        home: StartScreen(),
      ),
    );
  }
}
