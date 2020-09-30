import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:new_app/src/models/category.dart';
import 'package:new_app/src/models/countries_model.dart';
import 'package:new_app/src/models/new_models.dart';
import 'package:new_app/src/providers/user_preferences.dart';

class  NewsServices with ChangeNotifier {

  String _selectedCategory = 'general';
  final _prefs = new UserPreferences();

  List<Category> categories = [
    Category(FontAwesomeIcons.newspaper, 'All News', 'general'),
    Category(FontAwesomeIcons.building, 'Business', 'business'),
    Category(FontAwesomeIcons.tv, 'Entertainment', 'entertainment'),
    Category(FontAwesomeIcons.headSideVirus, 'Health', 'health'),
    Category(FontAwesomeIcons.vials, 'Science', 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'Sports', 'sports'),
    Category(FontAwesomeIcons.memory, 'Technology', 'technology')
  ];

  Map<String, dynamic> newsConfg = {
    "url_base": "https://newsapi.org/v2/",
    "api_key": "9021ee683b674f3098812707f20f029e",
    "endpoints": ['top-headlines', 'other-endpoint'],
    "country_code": "us",
    "country_code_slug": 'usa',
    "lang": 'EN'
  };

  void changeLang(String newLang){
    newsConfg['lang'] = newLang;
    _prefs.lang = newLang;
    notifyListeners();
  }

  List<Article> _headLines = [];

  void _chageCinConfig(Country newCountry){
    newsConfg['country_code'] = newCountry.countryCode;
    newsConfg['country_code_slug'] = newCountry.countrySlug;
  }
  
  /* Chage country in config and fetch new data  */
  void changec(Country newCountry){
    _chageCinConfig(newCountry);
    _prefs.userCountry = newCountry;
    _headLines = [];
    this.getTopHeadLines();
    categories.forEach((element) {
      this.categoryArticles[element.categoryId] = new List();
    });
    
    this.getArticlesByCategoty(this._selectedCategory);
  }

  List<Article>get headLines => _headLines;



  Map<String, List<Article>> categoryArticles = {};


  NewsServices() {
    Country userCountry = _prefs.userCountry;
    _chageCinConfig(userCountry); 
    newsConfg['lang'] = _prefs.lang;
    this.getTopHeadLines();
    categories.forEach((element) {
      this.categoryArticles[element.categoryId] = new List();
    });
    
    this.getArticlesByCategoty(this._selectedCategory);
  }

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String category){
    this._selectedCategory = category;
    this.getArticlesByCategoty(category);
    notifyListeners();
  }

  getTopHeadLines() async {
    final url = '${newsConfg['url_base']}${newsConfg['endpoints'][0]}?country=${newsConfg['country_code']}&apiKey=${newsConfg['api_key']}';
    final response = await http.get(url);

    final NewResponse newsResponse = newResponseFromJson(response.body);

    this._headLines.addAll(newsResponse.articles);
    notifyListeners();
  }


  getArticlesByCategoty(String category) async {
    if(this.categoryArticles[category].length > 0){
      print('Is Ready load...');
      return this.categoryArticles[category];
    }

    final url = '${newsConfg['url_base']}${newsConfg['endpoints'][0]}?country=${newsConfg['country_code']}&category=${this._selectedCategory}&apiKey=${newsConfg['api_key']}';
    final response = await http.get(url);

    final NewResponse newsResponse = newResponseFromJson(response.body);

    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }

  Future <List<Article>> getRelatedNews(String title) async {
    print(' ********** Get getRelatedNews **********');
    final url = '${newsConfg['url_base']}${newsConfg['endpoints'][0]}?country=${newsConfg['country_code']}&q=$title&pageSize=4&apiKey=${newsConfg['api_key']}';
    final response = await http.get(url);

    final NewResponse newsResponse = newResponseFromJson(response.body);

    return newsResponse.articles;
  }
}