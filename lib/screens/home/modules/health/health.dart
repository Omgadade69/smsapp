import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms/models/user.dart';
import 'package:sms/screens/home/modules/health/quarantinesummary.dart';
import 'package:sms/services/auth.dart';
import 'package:sms/services/database.dart';
import 'package:sms/shared/constants.dart';
import 'package:provider/provider.dart';

class Health extends StatefulWidget {
  static const String id = 'health';

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  String groupvalue = 'Healthy';

  DatabaseService db = DatabaseService();
  AuthService _auth = AuthService();
  int selectedindex = 0;
  @override
  void initState() {
    super.initState();
    getInitialstatus();
  }

  void getInitialstatus() async {
    DocumentSnapshot<Object?> result = await db.readIndividualHealthStatus(_auth.userId());
    DocumentSnapshot<Map<String, dynamic>> mappedResult = result as DocumentSnapshot<Map<String, dynamic>>;
    if (mappedResult.data()!['health'] != null) {
      setState(() {
        groupvalue = mappedResult.data()!['health'];
      });
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: selectedindex == 0 ? Text('Status') : Text('Quarantine Summary'),
      ),
      body: selectedindex == 0
          ? Column(
              children: [
                RadioListTile(
                  title: Text('Home Quarantined'),
                  value: 'Home Quarantined',
                  groupValue: groupvalue,
                  onChanged: (value) {
                    setState(() {
                      groupvalue = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Hospitalized'),
                  value: 'Hospitalized',
                  groupValue: groupvalue,
                  onChanged: (value) {
                    setState(() {
                      groupvalue = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Healthy'),
                  value: 'Healthy',
                  groupValue: groupvalue,
                  onChanged: (value) {
                    setState(() {
                      groupvalue = value!;
                    });
                  },
                ),
              ],
            )
          : QuarantineSummary(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedindex,
        backgroundColor: kXiketic,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Status',
            icon: Icon(
              Icons.medical_services,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Summary',
            icon: Icon(
              Icons.info,
            ),
          ),
        ],
        onTap: onItemTapped,
      ),
      floatingActionButton: Builder(
        builder: (context) => Visibility(
          visible: selectedindex == 0,
          child: FloatingActionButton(
            onPressed: () {
              db.addIndividualHealthStatus(user.uid, groupvalue);

              final snackBar = SnackBar(
                backgroundColor: kXiketic,
                duration: Duration(seconds: 1),
                content: Text(
                  'Status saved successfully',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Icon(
              Icons.save,
            ),
          ),
        ),
      ),
    );
  }
}
