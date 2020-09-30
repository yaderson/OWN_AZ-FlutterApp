import 'package:new_app/src/models/countries_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserPreferences {

  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }
  UserPreferences._internal();

  // bool _secondaryColor;
  // int _genre;
  // String _name;
  
  // GET & SET genre

  get isDarkMode{
    return _prefs.getBool('isDarkMode')??false;
  }

  set isDarkMode(bool value) {
    _prefs.setBool('isDarkMode', value);
  }


  //laguage

  get lang{
    return _prefs.getString('lang') ?? 'ES';
  }

  set lang(String lang){
    _prefs.setString('lang', lang);
  }

  //country

  get userCountry{
    final String initialCountry = 'us,usa';

    final String countryData = _prefs.getString('userCountry')??initialCountry;
    return  new Country(countryData.split(',')[0], countryData.split(',')[1]);
  }

  set userCountry(Country userCountry){
    _prefs.setString('userCountry','${userCountry.countryCode},${userCountry.countrySlug}');
  }




  
}