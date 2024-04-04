import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Users.dart';

class LoinScreen extends StatefulWidget {
  const LoinScreen({super.key});

  @override
  State<LoinScreen> createState() => _LoinScreenState();
}

class _LoinScreenState extends State<LoinScreen> {
  FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();
  Userapp user = Userapp(
    email: "admin@admin.com",
    firstName: "mohamed",
    lastName: "aoudi",
    phoneNumber: "0612345678",
    role: "admin",
    idProjet: "#1",
    id_user: "FirebaseAuth.instance.currentUser!.uid",
    password: "Admin@1234",
    photoUrl: 'https://firebasestorage.googleapis.com/v0/b/cinq-etoiles-f2bce.appspot.com/o/profil%2Fdefault_imag.png?alt=media&token=2746acb3-e5cd-4218-a036-e2372b93e3fa',
  );


  @override
  void initState() {
    super.initState();
    _firebaseServiceUser.registerWithEmailAndPassword("admin@admin.com", "Admin@1234",user );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
