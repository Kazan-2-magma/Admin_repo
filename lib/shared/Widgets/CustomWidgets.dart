
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
   required TextEditingController? editingController,
   required String? hintText,
   bool isObscureText = false,
   IconData? icon,
   Color? iconColor = Colors.blue,

}){
   return TextFormField(
     validator:funcValid,
     controller: editingController,
     decoration: InputDecoration(
       fillColor: Colors.white,
       filled: true,
       labelStyle: TextStyle(
         color: CustomColors.blue,
       ),
       labelText: hintText,
       enabledBorder: OutlineInputBorder(
         borderSide: BorderSide(
           color: CustomColors.blue,
           width: 2,
         ),
         borderRadius: BorderRadius.circular(10),
       ),
       focusedBorder: OutlineInputBorder(
         borderSide: BorderSide(
           color: CustomColors.blue,
           width: 1.5,
         ),
         borderRadius: BorderRadius.circular(13),
       ),
       prefixIcon: Icon(icon,color: iconColor,),
       border: OutlineInputBorder(),
          ),
         obscureText: isObscureText,

   );
 }
}