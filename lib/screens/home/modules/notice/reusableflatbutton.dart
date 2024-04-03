import 'package:flutter/material.dart';
import 'package:sms/screens/home/modules/notice/translation.dart';

class ReusableFlatButton extends StatelessWidget {
  final String outputLanguage;
  final String title;
  final String notice;

  ReusableFlatButton({required this.outputLanguage, required this.title, required this.notice});

  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Translate(
              notice: notice,
              title: title,
              outputLanguage: outputLanguage,
            ),
          ),
        );
      },
      child: Text(outputLanguage),
    );
  }
}
