import 'package:flutter/material.dart';
import 'package:new_app/src/providers/user_preferences.dart';

class ThemeModeService with ChangeNotifier {

  final _prefs = new UserPreferences();

  ThemeModeService(){
    initpre();
  }

  initpre() async{
    final val = await _prefs.isDarkMode;
    val?_themeMode = ThemeMode.dark:_themeMode = ThemeMode.light;
    print(val);
    notifyListeners();
  }

  ThemeMode _themeMode;
  

  get themeMode => _themeMode;
  
  

  changeMode(ThemeMode newThemeMode) async {
    if(newThemeMode == themeMode){
      return null;
    }else {
      
      bool isD = newThemeMode == ThemeMode.dark?true:newThemeMode == ThemeMode.light?false:false;
      print('SET DARK TO :::::: ${isD.toString()}');
      _prefs.isDarkMode = isD;
      _themeMode = newThemeMode;
      notifyListeners();
    }
  }

}