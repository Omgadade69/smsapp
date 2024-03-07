import 'package:flutter/material.dart';
import 'package:sms/shared/constants.dart';

class ReusableCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onpress;

  ReusableCard({required this.icon, required this.text, required this.onpress});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onpress as void Function(),
        child: Container(
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              )
            ],
          ),
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: kAmaranth,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
