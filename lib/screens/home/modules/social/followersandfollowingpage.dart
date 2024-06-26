import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms/screens/home/modules/social/otherusersprofilepage.dart';
import 'package:sms/shared/loading.dart';

class FollowersAndFollowing extends StatefulWidget {
  final String pageToDisplay;
  final String username;
  FollowersAndFollowing({required this.pageToDisplay, required this.username});

  @override
  _FollowersAndFollowingState createState() => _FollowersAndFollowingState();
}

class _FollowersAndFollowingState extends State<FollowersAndFollowing> {
  late String userid;
  late Query followersdisplay;
  late Query followingdisplay;
  List<String> followersUid = [];
  List<String> followingUid = [];
  int initialIndex = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('module_social_usernames')
        .doc(widget.username)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      userid = documentSnapshot.data()!['uid'];
      CollectionReference<Map<String, dynamic>> followers = FirebaseFirestore
          .instance
          .collection('module_social')
          .doc(userid)
          .collection('followers');
      CollectionReference<Map<String, dynamic>> following = FirebaseFirestore
          .instance
          .collection('module_social')
          .doc(userid)
          .collection('following');
      if (widget.pageToDisplay == 'following') {
        initialIndex = 1;
      }
      followers.get().then((value) {
        value.docs.forEach((doc) {
          followersUid.add(doc.data()['uid']);
        });
        if (followersUid.isNotEmpty) {
          setState(() {
            followersdisplay = FirebaseFirestore.instance
                .collection('module_social')
                .where('uid', whereIn: followersUid);
          });
        }
      });
      following.get().then((value) {
        value.docs.forEach((doc) {
          followingUid.add(doc.data()['uid']);
        });
        if (followingUid.isNotEmpty) {
          setState(() {
            followingdisplay = FirebaseFirestore.instance
                .collection('module_social')
                .where('uid', whereIn: followingUid);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.username),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              text: 'Followers',
            ),
            Tab(
              text: 'Following',
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            followersdisplay == 0
                ? Center(child: Text('No users to display'))
                : FollowersandFollowingdisplaytile(
                    displaytile: followersdisplay,
                    following: followingUid,
                  ),
            followingdisplay == 0
                ? Center(child: Text('No users to display'))
                : FollowersandFollowingdisplaytile(
                    displaytile: followingdisplay,
                    following: followingUid,
                  ),
          ],
        ),
      ),
    );
  }
}

class FollowersandFollowingdisplaytile extends StatelessWidget {
  FollowersandFollowingdisplaytile({required this.displaytile, required this.following});

  final Query displaytile;
  final List following;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: displaytile.get() as Future<QuerySnapshot<Map<String,dynamic>>>,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot<Map<String, dynamic>> document) {
            return ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return UserProfilePage(
                    uid: document.data()!['uid'],
                    username: document.data()!['username'],
                    following: following.contains(document.data()!['uid']),
                  );
                }));
              },
              leading: CircleAvatar(
                  backgroundImage: document.data()!['profile_picture'] == ''
                      ? AssetImage('assets/images/default_profile_pic.jpg') as ImageProvider
                      : NetworkImage(document.data()!['profile_picture'])),
              title: Text(document.data()!['username']),
            );
          }).toList(),
        );
      },
    );
  }
}
