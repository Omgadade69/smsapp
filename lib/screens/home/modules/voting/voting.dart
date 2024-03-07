import 'package:flutter/material.dart';
import 'package:sms/screens/home/modules/voting/addvoting.dart';
import 'package:sms/screens/home/modules/voting/realtimevotingupdate.dart';
import 'package:sms/shared/constants.dart';
import 'package:sms/services/database.dart';

class Voting extends StatefulWidget {
  static const String id = 'voting';

  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  dynamic userdata;
  late String userType;

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  Future getuserdata() async {
    userdata = await DatabaseService().getuserdata();
    setState(() {
      userType = userdata.data()['userType'];
    });

    print(userdata.data());
    print(userType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting'),
        actions: [
          Visibility(
            visible: userType == 'admin',
            child: IconButton(
                icon: Icon(Icons.add),
                color: kAmaranth,
                onPressed: () {
                  Navigator.pushNamed(context, AddVoting.id);
                }),
          )
        ],
      ),
      body: RealTimeVotingUpdate(),
    );
  }
}
