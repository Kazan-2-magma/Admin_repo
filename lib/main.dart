import 'package:cinq_etoils/screens/ClientScreen.dart';
import 'package:cinq_etoils/screens/auth_screen_manager.dart';
import 'package:cinq_etoils/screens/home_screen.dart';
import 'package:cinq_etoils/screens/login_screen.dart';
import 'package:cinq_etoils/screens/profile_screen.dart';
import 'package:cinq_etoils/screens/project_screen.dart';
import 'package:cinq_etoils/screens/users_list_screen.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp (MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Cinq Etoil Admin",
<<<<<<< HEAD
    home: ProfileScreen(), ////// try new look of the project screen ;D by MFox
=======
    home: ClientScreen(), ////// try new look of the ProjectScreen ;D by MFox
>>>>>>> 9d791fefb09c486025e34c11aff4b2d8b08833af
  ));

}

/*class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
      ),

    );
  }
}*/