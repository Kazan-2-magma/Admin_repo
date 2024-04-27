
import 'package:cinq_etoils/data_verification/email_password_verification.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/UserModel.dart';
import 'package:cinq_etoils/screens/home_screen.dart';
import 'package:cinq_etoils/screens/screens_manager.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:cinq_etoils/shared/shared_prefrences/shared_prefrences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../model/Users.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userEmailController = TextEditingController();
  TextEditingController emailRecovery = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController _emailRecovery = TextEditingController();
  var formKey = GlobalKey<FormState>(),btnSheetsFormKey = GlobalKey<FormState>();
  var emailMotDePassOublier = GlobalKey<FormState>();
  bool isLoading = false;
  String res = "";
  var data;
  FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColors.blue,
        title: const Text(
            "Cinq Etoiles",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: CustomColors.lightGrey,
          padding: EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: SingleChildScrollView(
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
                  margin: EdgeInsets.only(top: 20,right: 5,left: 5,bottom:5),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.grey,
                        spreadRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Container(
                    height: 350,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Connexion", style: TextStyle(fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.blue),),
                          CustomWidgets.customTextFormField(
                            inputType: TextInputType.emailAddress,
                            editingController: userEmailController,
                            hintText: 'Email',
                            icon: Icons.email,
                            funcValid: (value) {
                              if (value!.isEmpty)
                                return "L'e-mail est vide";
                              else if (!emailValidation(value)) {
                                return "L'e-mail n'est pas valide";
                              } else {
                                return null;
                              }
                            },
                          ),
                          CustomWidgets.customTextFormField(
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                                color: CustomColors.blue,),
                              onPressed: () {
                                setState(
                                      () {
                                    passwordVisible = !passwordVisible;
                                  },

                                );
                              },
                            ),
                            editingController: passwordController,
                            hintText: 'Mot de passe',
                            icon: Icons.lock,
                            isObscureText: passwordVisible,
                            funcValid: (value) {
                              if (value!.isEmpty)
                                return "Le mot de passe est vide";
                              else if (!passwordValidation(value)) {
                                return "Le mot de pass n'est pas valide";
                              } else if (value.length < 8) {
                                return "Le mot de pass doit être en mois de 8 characters";
                              } else {
                                return null;
                              }
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Mot de passe oublier?',
                                    style: const TextStyle(color: Colors.blue,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.blue
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                      //generateRandomPassword();
                                      CustomWidgets.showAlertDialog(context, "Mot de passe oublier?",
                                        children: Form(
                                          key : emailMotDePassOublier,
                                          child:CustomWidgets.customTextFormField(
                                            inputType: TextInputType.emailAddress,
                                            editingController: emailRecovery,
                                            hintText: 'Email',
                                            icon: Icons.email,
                                            funcValid: (value) {
                                              if (value!.isEmpty)
                                                return "L'e-mail est vide";
                                              else if (!emailValidation(value)) {
                                                return "L'e-mail n'est pas valide";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),),
                                        list: [
                                          CustomWidgets.customButton(
                                            text: Text("Envoyer"),
                                            func: ()  {
                                              if (emailMotDePassOublier.currentState!.validate()) {

                                                FirebaseAuth.instance.sendPasswordResetEmail(email: emailRecovery.text)
                                                .then((value){
                                                  CustomWidgets.showSnackBar(context,
                                                      "Le nouveau Mot de pass est evoyer a votre email:${emailRecovery.text}",
                                                      CustomColors.green
                                                  );
                                                }).catchError((e){
                                                  print(e.toString());
                                                });
                                                Navigator.pop(context);

                                              }
                                                else {
                                                  CustomWidgets.showSnackBar(
                                                      context,
                                                      "Login Failed",
                                                      CustomColors.red
                                                  );
                                                }
                                              }
                                            ,
                                            color: CustomColors.green),
                                          CustomWidgets.customButton(
                                            text: Text("Annuler"),
                                            func: ()  {
                                              Navigator.pop(context);
                                              }
                                            ,
                                            color: CustomColors.red),
                                        ]
                                      );
                                        print('Mot de passe oublier');
                                      }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            child: CustomWidgets.customButton(
                                text: isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: const CircularProgressIndicator())
                                :Text("Se Connecter"),
                                func: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (await signIn(context)) {
                                      print("Signed");
                                      // Navigator.of(context).pushReplacement(
                                      //     MaterialPageRoute(builder: (context) => ScreenManager())
                                      // );
                                    } else {
                                      CustomWidgets.showSnackBar(
                                          context,
                                          "Login Failed",
                                          CustomColors.red
                                      );
                                    }
                                  }
                                },
                                color: CustomColors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<bool> signIn(BuildContext context) async {
    bool signIn = false;
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmailController.text, password: passwordController.text)
    .then((value)async{
      await _firebaseServiceUser.getUserInfo(value.user!.uid)
      .then((value) async{
        if(value?["role"] != "admin"){
          await FirebaseAuth.instance.signOut();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Vous n'êtes pas autorisé à accéder à cette application, seuls les administrateurs peuvent se connecter"),backgroundColor: Colors.red,)
          );
          await AppPreferences.init();
          AppPreferences.preferences!.setBool("status", true);
          AppPreferences.setData("user_data", value!);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Vous vous êtes connecté avec succès"),backgroundColor: Colors.green,)
          );
          AdminUser? userData = AdminUser.fromJson(value);
          AppFunctions.navigateTo(context, ScreenManager(userData: userData,));
        }
      }).catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("La connexion a échoué"),backgroundColor: Colors.red,)
        );
      });
    }).catchError((e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("La connexion a échoué"),backgroundColor: Colors.red,)
      );
    });
    setState(() {
      isLoading = false;
    });
    return signIn;
  }




  }
