import 'package:flutter/material.dart';
import 'package:sms/models/user.dart';
import 'package:sms/shared/realtimecommentsupdate.dart';
import 'package:sms/services/database.dart';
import 'package:sms/shared/constants.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  final docid;
  final bool social;
  final comment;

  Comments({this.docid, required this.social, this.comment});

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final DatabaseService db = DatabaseService();
  String userNameSocial = '';


  @override
  void initState() {
    super.initState();
    getUserNameSocial();

  }



  void getUserNameSocial() async {
    userNameSocial = await db.getUserNameSocial();
    setState(() {});
    print(userNameSocial);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    dynamic comment;
    var _textController = TextEditingController();
    return Container(
      color: kSpaceCadet,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: RealTimeCommentUpdates(
              docid: widget.docid,
              social: widget.social,
              comment:widget.comment,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: TextField(
                    controller: _textController,
                    onChanged: (val) {
                      comment = val;
                    },
                    decoration: InputDecoration(
                       prefixIcon: IconButton(
                         onPressed: () {},
                          icon: Icon(
                           Icons.emoji_emotions,
                         ),
                       ),
                      fillColor: kSpaceCadet,
                      filled: true,
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    color: kAmaranth,
                    onPressed: () {
                      _textController.clear();

                      db.addComment(widget.social, widget.docid, user.name,
                          widget.comment, userNameSocial);
                    },
                    icon: Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
