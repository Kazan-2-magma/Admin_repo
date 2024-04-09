import 'package:flutter/cupertino.dart';

class CustomFunctions {
  static ClearTextFields(List<TextEditingController> list){
    for(int i = 0; i < list.length; i++){
      list[i].clear();
    }
  }
}