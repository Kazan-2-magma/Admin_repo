import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  Map<String,dynamic>? userData;
  HomeScreen({this.userData});

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
