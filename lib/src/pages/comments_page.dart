import 'package:flutter/material.dart';
import 'package:new_app/src/models/comments_model.dart';
import 'package:new_app/src/providers/commets_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsPage extends StatefulWidget {
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {

  final commentsProvider = CommentsProvider();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  String _myname = '';
  String _mycomment = '';
  String _newsId;
  Widget build(BuildContext context){
    final Map arguments = ModalRoute.of(context).settings.arguments;
    final String newsId = arguments['newsId'];
    setState(() {
      _newsId = newsId;
    });
    final List<Comments> comments = arguments['comments'];
    
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _writeComment(context),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
        icon: Icon(Icons.keyboard_arrow_left, size: 25),
        onPressed: () => Navigator.pop(context),
      ),
        title: Text('Comments'),
      ),
      body:  comments.length > 0?ListView(
        children: _buildComments(context, comments)
      ):Center(child: Text('Write the first Comment'),)
    );
  }

  List<Widget> _buildComments(BuildContext context ,List<Comments> comments){
    List<Widget> list = [];
    for(int i = 0; i <comments.length; i++){
      list.add(_comment(context, comments[i]));
      if(i == comments.length - 1){
        list.add(SizedBox(height: 70,));
      }
    }

    return list;
  }

  Widget _writeComment(BuildContext context){
    return Container(
      height: 70,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: ListTile(
          title: Text('Write a comment'),
          trailing: SafeArea(
            child: Icon(Icons.send, color: Theme.of(context).accentColor,)
          ),
          onTap: () => _showDialongWriteComment(context),
        ),
      ),
    );
  }

  void _showDialongWriteComment(BuildContext context){
    showDialog(context: context, builder: (context) {
      return Dialog(
        child: Scaffold(
          key: _scaffoldKey,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 50,
            width: double.infinity,
            child: FlatButton.icon(
              color: Theme.of(context).accentColor,
              disabledColor: Colors.grey,
              onPressed: () => (_myname !='' && _mycomment != '')?_sendComment(context, _myname, _mycomment):null,
              icon: Icon(Icons.send, color: Colors.white,),
              label: Container()
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text('Write your comment', style: TextStyle(fontSize: 15),),
            leading: FlatButton(
              child: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children:[
                  TextFormField(
                    initialValue: _myname,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      icon: Icon(Icons.person, color: Theme.of(context).accentColor,),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _myname = val;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: _mycomment,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'Comment',
                      icon: Icon(Icons.comment, color: Theme.of(context).accentColor,),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _mycomment = val;
                      });
                    },
                  )                  
                ]
              ),
            ),
          ),
        )
      );
    });
  }

  void _sendComment(BuildContext context, String name, String newcomment) async {
    Comments comment = new Comments(comment: newcomment, commentAt: new DateTime.now(), newsId: '', userId: '', username: name);
    await commentsProvider.sendComments(_newsId, comment);
    setState(() {
      _mycomment = '';
    });
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text('Your Comment was send Sucessesfull', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), backgroundColor: Colors.green)
    );
  }

  Widget _comment(BuildContext context, Comments comment){
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 60, width: 60, margin: EdgeInsets.only(right: 10) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).accentColor),),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(comment.username, style: TextStyle(fontWeight: FontWeight.bold),),
                    Container(margin: EdgeInsets.symmetric(horizontal: 5) ,child: Icon(Icons.fiber_manual_record, size: 5,)),
                    Text(timeago.format(comment.commentAt,locale: 'en')),
                    SizedBox(height: 30)
                  ],
                ),
                Text(comment.comment, style: TextStyle(fontSize: 16), maxLines: 10, overflow: TextOverflow.ellipsis),
                // InkWell(
                //   onTap: (){},
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border(bottom: BorderSide(color: Theme.of(context).accentColor, width: 2))
                //     ),
                //     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                //     child: Text('Reply')
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget _reply(){
  //   return Container(
  //     padding: EdgeInsets.symmetric( vertical: 20),
  //     width: double.infinity,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(height: 60, width: 60, margin: EdgeInsets.only(right: 10) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.blue),),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Row(
  //                 children: [
  //                   Text('User Name', style: TextStyle(fontWeight: FontWeight.bold),),
  //                   Container(margin: EdgeInsets.symmetric(horizontal: 5) ,child: Icon(Icons.fiber_manual_record, size: 5,)),
  //                   Text('45 Minutes Ago'),
  //                   SizedBox(height: 30)
  //                 ],
  //               ),
  //               Text('Perspiciatis unde omnis iste natus error sit voluptatem acussatium Perspiciatis unde omnis iste natus.')
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}