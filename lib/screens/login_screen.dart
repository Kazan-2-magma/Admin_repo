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



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
