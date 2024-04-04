import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../model/Users.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController
  userEmailController = TextEditingController(),
      passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.blue,
        title: Text("appBar"),
      ),
      body: SingleChildScrollView(
        child: Container(
            color: CustomColors.lightGrey,
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20,left: 30,right: 30),
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(

                        color: CustomColors.grey,
                        spreadRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    height: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Connexion",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: CustomColors.blue),),
                        CustomWidgets.CustomTextFormField(
                          editingController: userEmailController,
                          hintText: 'Email',
                          icon: Icons.email,
                          funcValid: (value){
                            //////////////////////////////
                          },
                        ),
                        CustomWidgets.CustomTextFormField(
                          editingController: passwordController,
                          hintText: 'Mot de passe',
                          icon: Icons.lock,
                          isObscureText: true,
                          funcValid: (value){
                            ///////////////////////////////////
                          },
                        ),
                        CustomWidgets.CustomButton(
                            text: "S'inscrire",
                            func: (){
                              ////////////////////////////////
                            },
                            color: CustomColors.green)
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}