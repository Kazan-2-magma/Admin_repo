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
    home: ClientScreen(),
  ));

}

