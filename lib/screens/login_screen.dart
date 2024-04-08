import 'package:cinq_etoils/data_verification/email_password_verification.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/UserModel.dart';
import 'package:cinq_etoils/screens/home_screen.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
  
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var data;
  FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.blue,
        title: const Text("appBar"),
      ),
      body: Container(
          height:MediaQuery.of(context).size.height,
          color: CustomColors.lightGrey,
          padding: EdgeInsets.all(30),
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
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.symmetric(horizontal: 45),
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
                          Text("Connexion",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: CustomColors.blue),),
                          CustomWidgets.customTextFormField(
                            editingController: userEmailController,
                            hintText: 'Email',
                            icon: Icons.email,
                            funcValid: (value){
                              if(value!.isEmpty) return "L'e-mail est vide";
                              else if(!emailValidation(value)){
                                return "L'e-mail n'est pas valide";
                              }else{
                                return null;
                              }
                            },
                          ),
                          CustomWidgets.customTextFormField(
                            editingController: passwordController,
                            hintText: 'Mot de passe',
                            icon: Icons.lock,
                            isObscureText: true,
                            funcValid: (value){
                              if(value!.isEmpty) return "Le mot de passe est vide";
                              else if(!passwordValidation(value)){
                                return "Le mot de pass n'est pas valide";
                              }else if(value.length < 8){
                                return "Le mot de pass doit être en mois de 8 characters";
                              }else{
                                return null;
                              }
                            },
                          ),
            
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Mot de passe oublier?',
                                  style: TextStyle(color: Colors.blue, fontSize: 15.0),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print('Mot de passe oublier"');
                                    }),
                            ],
                          ),
                        ),
            
            
                          CustomWidgets.customButton(
                              text: "Se Connecter",
                              func: () async{
                                if(formKey.currentState!.validate()){
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if(await signIn()){
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) => HomeScreen(userData:data))
                                      );
                                    }else{
                                      CustomWidgets.showSnackBar(
                                          context,
                                          "Login Falide",
                                          CustomColors.red
                                      );
                                    }
                                }
                              },
                              color: CustomColors.green)
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
    List<UserModel> currentUser = await _firebaseServiceUser.rechercheUserParEmailEtPassword(
        userEmailController.text, passwordController.text,);
    //print(currentUser);
    if(currentUser.isNotEmpty){
      UserModel? user = currentUser.first;
      if(user.role == "admin"){
        String? res = await _firebaseServiceUser.signInWithEmailAndPassword(
          userEmailController.text,
          passwordController.text,
        );
        if(res == null){
          CustomWidgets.showSnackBar(
              context,
              "Succès Vous êtes connecté",
              CustomColors.green
          );
          data = await _firebaseServiceUser.getUserInfo(user.id_user);
          print(data);
          signIn = true;
        }
      }
    }else{
      CustomWidgets.showSnackBar(
          context,
          "Erreur Cette application est réservée aux administrateurs.",
          CustomColors.red
      );
      signIn = false;
    }
    return signIn;

  }
}