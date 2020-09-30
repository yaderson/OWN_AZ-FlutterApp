import 'package:flutter/material.dart';
import 'package:new_app/src/services/news_service.dart';
import 'package:new_app/src/theme/dark_theme.dart';
import 'package:new_app/src/utils/utils_widget.dart';
import 'package:new_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';


class ExploreTab extends StatefulWidget {
  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  
  
  @override


  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsServices>(context);
    
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Image(
              height: 100,
              image: AssetImage(darkLogo),
            ),
          ),
          bottom: _buildTabBar(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15,),
              (newsService.categoryArticles[newsService.selectedCategory].length > 0)?
                NewsList(newsService.categoryArticles[newsService.selectedCategory]):
                  loadingArticles(context)
            ],
          ),
        )
      ),
    );
  }

  TabBar _buildTabBar(BuildContext context) {
    final newsService = Provider.of<NewsServices>(context, listen: false);
    
    return TabBar(
      physics: BouncingScrollPhysics(),
      
      indicatorColor: Theme.of(context).accentColor,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      onTap: (val){
        newsService.selectedCategory = newsService.categories[val].categoryId;
      },
      tabs: newsService.categories.map((e) => Tab(icon: Icon(e.icon, size: 20), text: e.name,)).toList()
    );
  }
}