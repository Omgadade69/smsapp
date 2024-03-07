import 'package:flutter/material.dart';
import 'package:sms/models/user.dart';
import 'package:sms/screens/authenticate/authenticate.dart';
import 'package:sms/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}