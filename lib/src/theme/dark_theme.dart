import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  accentColor: Color.fromRGBO(255, 102, 30, 1),
  unselectedWidgetColor: Colors.white,
  toggleableActiveColor: Color.fromRGBO(255, 102, 30, 1),
  cardTheme: CardTheme(
    color: Colors.black26
  ),

  
);
final String darkLogo = 'assets/own-az-dark.png';
final String lightLogo = 'assets/own-az-light.png';
final lightTheme = ThemeData.light().copyWith(
  cardTheme: CardTheme(
    color: Colors.white
  ),
  accentColor: Color.fromRGBO(255, 102, 30, 1),
  primaryColor: Colors.white,
  toggleableActiveColor: Color.fromRGBO(255, 102, 30, 1),
  unselectedWidgetColor: Colors.black,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      //color: Colors.black
    ),
    textTheme: TextTheme(headline6: TextStyle(color: Colors.black, fontSize: 25))
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.black
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.grey,
    labelColor: Colors.black
  )
);