import 'package:flutter/material.dart';
import 'package:new_app/src/pages/tabs/explore_tab.dart';
import 'package:new_app/src/pages/tabs/home_tab.dart';
import 'package:new_app/src/pages/tabs/saved_tab.dart';
import 'package:new_app/src/pages/tabs/settings_tab.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (_) => new _NavigatorModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigatorModel = Provider.of<_NavigatorModel>(context);
    return Theme(
      data: ThemeData(
        canvasColor: Theme.of(context).primaryColor
      ),
      child: BottomNavigationBar(
        
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        currentIndex: navigatorModel.actualPage,
        onTap: (val) => navigatorModel.actualPage = val,
        items: [
          
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.public), title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Container()),
        ],
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigatorModel = Provider.of<_NavigatorModel>(context);
    return PageView(
      controller: navigatorModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        HomeTab(),
        ExploreTab(),
        SavedTab(),
        SettingsTab()
      ],
    );
  }
}

class _NavigatorModel with ChangeNotifier {
  int _actualPage = 0;

  PageController _pageController = new PageController();



  int get actualPage => _actualPage;

  set actualPage(int value){
    this._actualPage = value;
    _pageController.animateToPage(value, duration: Duration(microseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}