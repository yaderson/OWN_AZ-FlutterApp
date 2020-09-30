import 'package:flutter/material.dart';
import 'package:new_app/src/services/countries_list.dart';
import 'package:new_app/src/services/news_service.dart';
import 'package:new_app/src/services/themeMode_service.dart';
import 'package:provider/provider.dart';


class SettingsTab extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _tobar(context),
              _body(context)
            ],
          ),
        ),
      )
    );
  }

  Widget _body(BuildContext context){
    final themeModeService = Provider.of<ThemeModeService>(context);
    final newsService = Provider.of<NewsServices>(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  value: themeModeService.themeMode == ThemeMode.dark?true:false,
                  onChanged: (val){
                    themeModeService.changeMode(val == true?ThemeMode.dark:ThemeMode.light);
                  },
                  title: Text('Dark Mode'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton(
                    value: newsService.newsConfg['country_code'],
                    onChanged: (value){
                      print(value);
                      final a = countries.firstWhere((c) => c.countryCode == value);
                      newsService.changec(a);
                    },
                    items: countries.map(
                      (e) => DropdownMenuItem(
                        onTap: (){},
                        value: e.countryCode,
                        child:Row(
                          children: [
                            Image(
                              image: AssetImage('assets/flags/${e.countrySlug}.png'),
                            ),
                            Text(e.countrySlug),
                          ],
                        ),
                      )
                    ).toList(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton(
                    value: newsService.newsConfg['lang'],
                    onChanged: (value) { 
                      newsService.changeLang(value);  
                    },
                    items: ['ES', 'EN'].map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )
                    ).toList()
                  ),
                )
              ],
            )
          ),
          SizedBox(height: 20,),
          Text('Account'),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).primaryColor
            ),
            child: Column(
              children: [
                ListTile(title: Text('Edit Account'), trailing: Icon(Icons.keyboard_arrow_right), onTap: (){},),
                ListTile(title: Text('Change Password'), trailing: Icon(Icons.keyboard_arrow_right),onTap: (){})
              ],
            )
          ),
          Padding(padding: EdgeInsets.only(top: 40),),
          Center(
            child: Text('Made by Yader'),
          )
        ],
      ),
    );
  }

  Container _tobar(BuildContext context) {
    return Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 0),
                Container(
                  child: Text('Settings', style: TextStyle(fontSize: 35),),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(50)
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('User Name', style: Theme.of(context).textTheme.headline6,),
                            SizedBox(height: 5,),
                            Text('useremail@email.com'),
                            OutlineButton(
                              borderSide: BorderSide(width: 0, color: Colors.transparent),
                              onPressed: (){},
                              child: Text('Sign Out', style: TextStyle(color: Theme.of(context).accentColor)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
  }
}