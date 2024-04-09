
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:cinq_etoils/screens/home_screen.dart';
import 'package:cinq_etoils/screens/screens_manager.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final FirebaseServiceUser firebaseService=FirebaseServiceUser();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return FutureBuilder<Map<String, dynamic>?>(
                future: firebaseService.getUserInfo(snapshot.data!.uid),
                builder: (context,dataSnapshot){
                  if(dataSnapshot.connectionState == ConnectionState.waiting){
                    return const  Center(
                      child : CircularProgressIndicator()
                    );
                  }else if(dataSnapshot.hasData){
                    return ScreenManager(userData: AdminUser.fromJson(dataSnapshot.data),);
                  }else{
                    return const Text("ERROR");
                  }
            }
            );
          }else{
            return LoginScreen();
          }
        },

      ),


    );
  }
}