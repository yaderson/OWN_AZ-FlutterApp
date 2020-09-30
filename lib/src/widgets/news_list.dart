import 'package:flutter/material.dart';
import 'package:new_app/src/models/new_models.dart';
import 'package:new_app/src/services/news_service.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsList extends StatelessWidget {

  final List<Article> articles;

  const NewsList(this.articles);
  
  @override
  Widget build(BuildContext context){
    return Column(
      children: articles.map(
        (element) => InkWell(
          onTap: () => Navigator.pushNamed(context, 'opennews', arguments: element),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 5),
            child: _articleNews(context, element)
          ),
        ) 
      ).toList()
    );
  }

  Widget _articleNews(BuildContext context, Article article) {
    final newsService = Provider.of<NewsServices>(context);
    return Stack(
      
      children: [
       
        Container(
          height: 150,
          child: Container(
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
              color: Theme.of(context).cardTheme.color,
            ),
            margin: EdgeInsets.only(top: 20, bottom: 20, left: 20),
            child:Row(
              children: [
                Container(
                  height: 100,
                  width: 80,
                  
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: ListTile(
                      title: Container(
                        height: 56,
                        child: Text(article.title,style: TextStyle(fontWeight: FontWeight.bold),  overflow: TextOverflow.ellipsis, maxLines: 3,)
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(timeago.format(article.publishedAt, locale: newsService.newsConfg['lang'].toString().toLowerCase()), style: TextStyle(fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.bookmark, size: 15,),
                            onPressed: (){},
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
        ),
        
        Container(
          margin: EdgeInsets.only(),
          height: 100,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              fit: BoxFit.cover,
              image: article.urlToImage !=null ? NetworkImage(article.urlToImage): AssetImage('assets/no-image.png'), 
              placeholder: AssetImage('assets/loading.gif'),
              placeholderErrorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.amber,
                  child: Center(
                    child: Text('$error'),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}