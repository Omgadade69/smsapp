import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/screens/wrapper.dart';
import 'package:sms/services/auth.dart';
import 'firebase_options.dart';
import 'package:sms/models/user.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // From this class further task carried out
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CurrentUser?>.value(value: AuthService().user, initialData: null,
    child: MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21)
    ),
        home:Wrapper(),
        routes: routes,
       ),
      );
  }
}
