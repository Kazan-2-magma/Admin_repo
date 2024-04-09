import 'package:cinq_etoils/model/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  AdminUser? adminUser;
  HomeScreen({this.adminUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "HOME"
        ),
      ),
    );
  }
}
