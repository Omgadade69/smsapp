import 'package:flutter/material.dart';
import 'package:sms/screens/home/modules/notice/addnotice.dart';
import 'package:sms/screens/home/modules/notice/realtimenoticeupdate.dart';
import 'package:sms/services/database.dart';
import 'package:sms/shared/constants.dart';

class Notice extends StatefulWidget {
  static const String id = 'notice';

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  late String userType;
  String noticeType = 'notice';
  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  Future getuserdata() async {
    dynamic userdata = await DatabaseService().getuserdata();
    setState(() {
      userType = userdata.data()['userType'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notice'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: userType == 'admin',
        child: FloatingActionButton(
          onPressed: () {
            print('click');
            Navigator.pushNamed(context, AddNotice.id);
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      body: RealTimeNoticeUpdate(
        noticeType: noticeType,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: kOxfordBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {
                setState(() {
                  noticeType = 'notice';
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: noticeType == 'notice' ? kAmaranth : Colors.white,
              ),
              icon: Icon(Icons.info),
              label: Text('Notice'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: noticeType == 'event' ? kAmaranth : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  noticeType = 'event';
                });
              },
              icon: Icon(Icons.event),
              label: Text('Event'),
            ),
          ],
        ),
      ),
    );
  }
}
