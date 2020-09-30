import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_app/src/models/comments_model.dart';
import 'package:new_app/src/models/new_models.dart';
import 'package:new_app/src/providers/commets_provider.dart';
import 'package:new_app/src/services/news_service.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:new_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final commentsProvider = new CommentsProvider();
  
  @override 

  Widget build(BuildContext context) {

    final Article _article = ModalRoute.of(context).settings.arguments;
    print(_article.newsId());
    
    return Scaffold(
      body: FutureBuilder(
        future: commentsProvider.getComments(_article.newsId()),
        builder: (context,AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            final List<Comments> comments = snapshot.data;
            return CustomScrollView(
              slivers: [
                _appbar(context ,_article, comments.length),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _newsBody(context, _article, comments),
                      _relatednews(context, _article.title.split(' ')[0])
                    ]
                  ),
                )
              ],
            );
          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _newsBody(BuildContext context, Article article, List<Comments> comments){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Theme.of(context).accentColor, width: 3)
              )
            ),
            child: Text(article.title.split(' - ')[0], maxLines: 3, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),overflow: TextOverflow.ellipsis,)
          ),
          SizedBox(height: 30),
          article.content != null?Text(article.content.split('[')[0], style: TextStyle(fontSize: 16, ), textAlign: TextAlign.left,):Container(),
          FlatButton(
            onPressed: () => _launchURL(article.url),
            child: Row(
              children: [
                article.content != null?Text(article.content.split('[')[1].split(']')[0]):Text('Open'),
                Icon(Icons.open_in_new)
              ],
            )
          ),
          SizedBox(height: 30),
          Center(
            child: Container(
              width: double.infinity,
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pushNamed(context, 'comments', arguments: {'comments': comments,'newsId': article.newsId()}),
                child: Text('See comments (${comments.length})', style: TextStyle(color: Colors.white, fontSize: 16),),
                
              ),
            ),
          ),
          SizedBox(height: 30),
          Text('Related news', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 30),
          
        ],
      ),
    );
  }

  Widget _relatednews(BuildContext context, String q) {
    final newsService = Provider.of<NewsServices>(context);
    return FutureBuilder(
      future: newsService.getRelatedNews(q),
      builder: (context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          List<Article> relatedArticles = snapshot.data;
          if(relatedArticles.length > 0){
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: NewsList(relatedArticles),
            );
          }else {
            return Container(
              height: 100,
              child: Center(
                child: Text('No Related News'),
              ),
            );
          }
        }else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _appbar(BuildContext context, Article _article, int commnets){
    final newsService = Provider.of<NewsServices>(context);
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      bottom: _bottomSliverBar(timeago.format(_article.publishedAt, locale: newsService.newsConfg['lang'].toString().toLowerCase()), commnets),
      actions: [
        IconButton(
          icon: Icon(Icons.reply, size: 25, color: Colors.white),
          onPressed: (){},
        ),
        IconButton(
          icon: Icon(Icons.bookmark, size: 20, color: Colors.white),
          onPressed: (){},
        )
      ],
      leading: IconButton(
        icon: Icon(Icons.keyboard_arrow_left, size: 25),
        onPressed: () => Navigator.pop(context),
      ),
      pinned: true,
      expandedHeight: 250,
      flexibleSpace: Container(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            image: _article.urlToImage != null?NetworkImage(_article.urlToImage):AssetImage('assets/no-image.png'),
          ),
        ),
      ),
    );
  }

  PreferredSize _bottomSliverBar(String time, int comments) {
    
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Text(time, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.solidComment, size: 15, color: Colors.white),
                SizedBox(width: 5,),
                Text(comments.toString())
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Icon(Icons.remove_red_eye, size: 20,  color: Colors.white),
                SizedBox(width: 5,),
                Text('916')
              ],
            ),
          ),
          
        ],
      )
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}