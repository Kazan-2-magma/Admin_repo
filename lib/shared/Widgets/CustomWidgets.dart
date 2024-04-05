
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

 // Fblast SizedBox ou dakchi
 static Widget verticalSpace(double height) => SizedBox(height: height,);
 static Widget horizontalSpace(double width) => SizedBox(width: width,);

 static Widget CustomDivider() => Padding(
   padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
   child: Divider(height: 1.0,color: CustomColors.grey,),
 );

 static Widget CustomIconButton({
   required VoidCallback func,
   required Icon icon,
   Color? color,
}){
   return IconButton(
     color: color,
     onPressed: func,
     icon: icon,
   );
 }
/////////////////////////yassin 7ta t9ad dakchi nta3 data 3awed sorry ;3
 static Widget CustomCard(Map data) => Card(
   shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
   elevation: 0.6,
   child: ClipPath(
     clipper: ShapeBorderClipper(
         shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10))),
     child: Container(
       decoration: BoxDecoration(
         border: Border(
           left: BorderSide(color: CustomColors.green, width: 7),
         ),
       ),
       child: ListTile(

           contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
           title: Text("project",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
           subtitle:Text("Email: \nTel: "),
           trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children:
             [
               VerticalDivider(),
               CustomWidgets.CustomIconButton(
                 func: (){
                   ///////////////////////////////////////
                 },
                 icon:Icon(
                   Icons.edit,
                   color: CustomColors.green,
                 ),
               ),
               CustomWidgets.CustomIconButton(
                 func: (){
                   ///////////////////////////////////////
                 },
                 icon:Icon(
                   Icons.delete,
                   color: CustomColors.red,
                 ),
               ),
             ],
           )
       ),
     ),
   ),
 );

}