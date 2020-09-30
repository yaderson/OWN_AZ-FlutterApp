import 'package:flutter/material.dart';
import 'package:new_app/src/pages/comments_page.dart';
import 'package:new_app/src/pages/home_page.dart';
import 'package:new_app/src/pages/news_page.dart';
import 'package:new_app/src/providers/user_preferences.dart';
import 'package:new_app/src/services/news_service.dart';
import 'package:new_app/src/services/themeMode_service.dart';
import 'package:new_app/src/theme/dark_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = new UserPreferences();
  await pref.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new NewsServices(),),
        ChangeNotifierProvider(create: (_) => new ThemeModeService(),)
      ],
      child: MaterialThemeApp()
    );
  }
}

class MaterialThemeApp extends StatelessWidget{
  Widget build(BuildContext context){
    final themeModeService = Provider.of<ThemeModeService>(context); 
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: themeModeService.themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: 'homepage',
      routes: {
        'homepage': (BuildContext context) => HomePage(),
        'opennews': (BuildContext context) => NewsPage(),
        'comments': (BuildContext context) => CommentsPage()
      },
    );
  }
}