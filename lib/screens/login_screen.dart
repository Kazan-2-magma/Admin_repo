import 'dart:math';

import 'package:cinq_etoils/data_verification/email_password_verification.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/UserModel.dart';
import 'package:cinq_etoils/screens/home_screen.dart';
import 'package:cinq_etoils/screens/screens_manager.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
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
        backgroundColor: CustomColors.blue,
        title: const Text("Cinq Etoiles"),
      ),
      body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
                                            text: "Envoyer",
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
                                            text: "Annuler",
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
                          CustomWidgets.customButton(
                              text: "Se connecter",
                              func: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (await signIn()) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) =>
                                            ScreenManager())
                                    );
                                  } else {
                                    CustomWidgets.showSnackBar(
                                        context,
                                        "Login Falide",
                                        CustomColors.red
                                    );
                                  }
                                }
                              },
                              color: CustomColors.green),
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

  Future<bool> signIn() async {
    bool signIn = false;
    setState(() {
      isLoading = true;
    });
    List<UserModel> currentUser = await _firebaseServiceUser
        .rechercheUserParEmailEtPassword(
      userEmailController.text, passwordController.text,);
    print(currentUser.first.id_user);
    if (currentUser.isNotEmpty) {
      UserModel? user = currentUser.first;
      if (user.role == "admin") {
        String? res = await _firebaseServiceUser.signInWithEmailAndPassword(
          userEmailController.text,
          passwordController.text,
        );
        if (res == null) {
          CustomWidgets.showSnackBar(
              context,
              "Succès Vous êtes connecté",
              CustomColors.green
          );
          data = await _firebaseServiceUser.getUserInfo(user.id_user);
          print("sign in data : ${data}");
          signIn = true;
        }
      }
    } else {
      CustomWidgets.showSnackBar(
          context,
          "Erreur Cette application est réservée aux administrateurs.",
          CustomColors.red
      );
      signIn = false;
    }
    return signIn;
  }


  String generateRandomPassword(){
    var letters_Min =["a", "b", "c", "d", "e", "f","g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v","w", "x", "y", "z"];
    var letters_Maj =["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K","L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W", "X", "Y", "Z"];
    var numbers =["0","1","2","3","4","5","6","7","8","9"];
    var special_Chars =["!","@","#","%","^","&","*","_","-","<",">",".","?","/"];
    int length = Random().nextInt(4)+6;
    print(length);
    var new_Password = [];
    for (int i = 0; i < length; i++) {
      new_Password.add(letters_Min[Random().nextInt(letters_Min.length)]);
      new_Password.add(letters_Maj[Random().nextInt(letters_Maj.length)]);
      new_Password.add(numbers[Random().nextInt(numbers.length)]);
      new_Password.add(letters_Maj[Random().nextInt(letters_Maj.length)]);
      new_Password.add(numbers[Random().nextInt(numbers.length)]);
    }
    new_Password.shuffle();
    new_Password = new_Password.sublist(0,length);
    String new_Pass = "";
    for (int i = 0; i < new_Password.length; i++) {
      new_Pass += new_Password[i];
    }
    print(new_Password);
    print(new_Pass);

    return new_Pass;



  }


  }
