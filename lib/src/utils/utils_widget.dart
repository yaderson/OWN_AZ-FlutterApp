import 'package:flutter/material.dart';

Widget loadingArticles(BuildContext context){
  return Container(
    margin: EdgeInsets.only(left: 20),
    child: Column(
      children: [
        _articleNewsLoad(context),
        _articleNewsLoad(context),
        _articleNewsLoad(context),
      ],
    ),
  );
}

Widget _articleNewsLoad(BuildContext context) {
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
                      child: _pholder(Theme.of(context).cardTheme.color)
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 10,
                          child: _pholder(Theme.of(context).cardTheme.color),
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark, size: 15, color: Theme.of(context).cardTheme.color,),
                          onPressed: null,
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
          child: _pholder(Theme.of(context).cardTheme.color)
        ),
      ),
    ],
  );
}

Widget _pholder(Color color){
  return Container(height: 10, width: double.infinity, color: color,);
}
