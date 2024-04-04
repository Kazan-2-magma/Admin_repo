
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../CustomColors.dart';

class CustomWidgets{



 static Widget CustomButton({
   required String text,
   required VoidCallback func,
   required Color color,
   Icon? icon,
}){
   return ElevatedButton(
     child: Text(
         text,
     style: TextStyle(fontSize: 18),),
     onPressed: func,
     style: ElevatedButton.styleFrom(
       backgroundColor: color,
       foregroundColor: CustomColors.white,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10),
       ),
     ),

   );
 }

 static Widget CustomTextFormField({
   BuildContext? context,
   required String? Function(String?)? funcValid,
   TextEditingController? editingController,

}){
   InputDecorationTheme inputDecorationTheme = Theme.of(context!).inputDecorationTheme;
   return TextFormField(
    validator:funcValid,
     controller: editingController,
     //decoration: (),
   );
 }
}