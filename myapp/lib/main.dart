import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/admin_files/musicaction.dart';
import 'package:myapp/admin_files/useraction.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/login/login.dart';
import 'package:myapp/admin_files/admin.dart';
import 'package:myapp/uifiles/home.dart';
import 'package:myapp/uifiles/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBOE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => LoginPage(), 
        '/home': (context) => HomePage(),
        '/profile':(context) => ProfilePage(email: '',), 
        '/admin': (context) => AdminPage(email: '',),
        '/UserAction': (context) => UserAction(),
        '/MusicAction': (context) => MusicAction(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
