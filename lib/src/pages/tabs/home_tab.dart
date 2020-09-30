import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:new_app/src/services/news_service.dart';
import 'package:new_app/src/services/themeMode_service.dart';
import 'package:new_app/src/theme/dark_theme.dart';
import 'package:new_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';


class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsServices>(context);
    final themeModeService = Provider.of<ThemeModeService>(context); 
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image(
            height: 100,
            image: AssetImage(themeModeService.themeMode == ThemeMode.dark?darkLogo:lightLogo),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            newsService.headLines.length != 0?_topSwipper(newsService, context):_load(200),
            SizedBox(height: 0,),
            newsService.headLines.length != 0?NewsList(newsService.headLines):_load(400),
          ],
        ),
      )
    );
  }
  Widget _load(double height) {
    return Container(
      color: Colors.black26,
      height: height,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  Container _topSwipper(NewsServices newsService, BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.only(bottom: 10, top: 15),
      child: Swiper(
        
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                  //margin: EdgeInsets.only(bottom: 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        image: newsService.headLines[index].urlToImage != null?NetworkImage(newsService.headLines[index].urlToImage):AssetImage('assets/no-image.png'),
                        placeholder: AssetImage('assets/loading.gif'),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('2 hours ago', style: TextStyle(color: Colors.white),),
                              IconButton(
                                icon: Icon(Icons.bookmark, size: 20, color: Colors.white,),
                                onPressed: (){},
                              )
                            ],
                          ),
                        ),
                        Expanded(child: Container(),),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 60,
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 35),
                          child: Text(newsService.headLines[index].title, style: TextStyle(color: Colors.white, fontSize: 25), maxLines: 2, overflow: TextOverflow.ellipsis,),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.white,
            color: Theme.of(context).accentColor
          ),
          margin: new EdgeInsets.all(0)
        ),
        itemCount: 4,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}