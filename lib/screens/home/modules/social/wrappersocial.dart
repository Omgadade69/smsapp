import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms/models/user.dart';
import 'package:sms/screens/home/modules/social/defaultprofilepage.dart';
import 'package:sms/screens/home/modules/social/homepage.dart';
import 'package:sms/screens/home/modules/social/searchpage.dart';
import 'package:sms/screens/home/modules/social/setusername.dart';
import 'package:sms/screens/home/modules/social/uploadpage.dart';
import 'package:sms/services/auth.dart';
import 'package:sms/services/storage.dart';
import 'package:sms/shared/constants.dart';
import 'package:sms/shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class WrapperSocial extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _WrapperSocialState createState() => _WrapperSocialState();
}

class _WrapperSocialState extends State<WrapperSocial> {
  int _selectedIndex = 0;
  late File photo;
  final picker = ImagePicker();
  StorageService storage = StorageService();
  String username = '';
  DocumentReference<Map<String, dynamic>> moduleSocial = FirebaseFirestore
      .instance
      .collection('module_social')
      .doc(AuthService().userId());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetoptions = [
    HomePageSocial(),
    SearchPage(),
    //Text('c'),
    ProfilePage(uid: ''),
  ];

  @override
  void initState() {
    super.initState();
    moduleSocial.get().then((document) {
      setState(() {
        username = document.data()!['username'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    List<Widget> _appbartitleoptions = [
      Text('Home'),
      Text('Search'),
      //  Text('Activity'),
      Text(username),
    ];

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: moduleSocial.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          if (snapshot.data!['username'] == '') {
            return SetUserName();
          }
          return Scaffold(
            appBar: AppBar(
              title: _appbartitleoptions.elementAt(_selectedIndex),
              actions: [
                Visibility(
                  visible: _selectedIndex == 2,
                  child: IconButton(
                    icon: Icon(Icons.add_box),
                    color: kAmaranth,
                    onPressed: () {
                      print(username);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return UploadPage(
                            username: username,
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
            body: _widgetoptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: kOxfordBlue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                  backgroundColor: kOxfordBlue,
                ),
                BottomNavigationBarItem(
                  icon: CircleAvatar(
                    backgroundImage: user.profilePicture == null
                        ? const AssetImage('assets/images/default_profile_pic.jpg') as ImageProvider
                        : NetworkImage(user.profilePicture as String),
                    radius: 12,
                  ),
                  label: 'Profile',
                  backgroundColor: kOxfordBlue,
                ),
              ],
              currentIndex: _selectedIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.shifting,
              onTap: _onItemTapped,
              selectedItemColor: kAmaranth,
            ),
          );
        });
  }
}
