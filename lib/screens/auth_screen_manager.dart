
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:cinq_etoils/screens/home_screen.dart';
import 'package:cinq_etoils/screens/screens_manager.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:cinq_etoils/shared/shared_prefrences/shared_prefrences.dart';
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
  bool status = false;
  Map<String,dynamic>? data;

  @override
  void initState() {
    super.initState();
    initReferences();
  }

  void initReferences()async{
    await AppPreferences.init();
    status =(await AppPreferences.preferences!.getBool("status")) ?? false;
    data = await AppPreferences.getData("user_data");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasData){
            return FutureBuilder(
                future: firebaseService.getUserInfo(snapshot.data!.uid),
                builder: (context,snapData){
                  if(snapData.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(snapData.hasData && snapData.data!["role"] == "admin"){
                    return ScreenManager(userData: AdminUser.fromJson(snapData.data),);
                  }else if(snapData.hasError){
                    return const Center(
                      child: Text(
                        "ERROR DE CONNECTION"
                      ),
                    );
                  }
                  else{
                    return LoginScreen();
                  }
                }
            );
          }else{
            return LoginScreen();
          }
        }
    );
  }
}