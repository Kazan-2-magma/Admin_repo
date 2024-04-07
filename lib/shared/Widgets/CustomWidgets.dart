
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../CustomColors.dart';

class CustomWidgets{




 static Widget customButton({
   required String text,
   required VoidCallback func,
   required Color color,
   Icon? icon,
}){
   return ElevatedButton(
     onPressed: func,
     style: ElevatedButton.styleFrom(
       backgroundColor: color,
       foregroundColor: CustomColors.white,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10),
       ),
     ),
     child: Text(
         text,
     style: const TextStyle(fontSize: 18),),

   );
 }


 static Widget customButtonWithIcon({
   required String text,
   required VoidCallback func,
   double radius = 10.0,
   Color? color,
   IconData? icon,
   int? radius,
 }){
   return ElevatedButton.icon(

     onPressed: func,
     style: ElevatedButton.styleFrom(
       backgroundColor: color,
       foregroundColor: CustomColors.white,
       shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),

       ),
     ),
     icon: Icon(icon),
     label: Text(
       text,
       style: const TextStyle(fontSize: 18),),
   );
 }

 static Widget customTextFormField({
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

 static Widget customDivider() => Padding(
   padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
   child: Divider(height: 1.0,color: CustomColors.grey,),
 );

 static Widget customIconButton({
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

 static Widget customCard(Map data,{bool checkbox = false,bool isUser = false}) => Card(
   shape: const RoundedRectangleBorder(
       borderRadius: BorderRadius.only(
           topLeft: Radius.circular(10),
           bottomLeft: Radius.circular(10)
       )
   ),
   elevation: 0.6,
   child: ClipPath(
     clipper: ShapeBorderClipper(
         shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10)
         )
     ),
     child: Container(
       decoration: BoxDecoration(
         border: Border(
           left: BorderSide(color: CustomColors.green, width: 7),
         ),
       ),
       child: checkbox
           ? ListTile(
             contentPadding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
             title: Text(
               "NAME",
               style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),
             ),
             subtitle:Text("Email: \nTel: ")  ,
             trailing: Row(
               mainAxisSize: MainAxisSize.min,
               children:
               [
                 const VerticalDivider(),
                 Checkbox(
                     value: false,
                     onChanged: (value){

                     }
                 ),
                 CustomWidgets.customIconButton(
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
       )
           : ListTile(
               contentPadding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
               title: Text(
                 "NAME",
                 style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),
               ),
               subtitle: isUser ? Text("Email: \nTel: \nRole :") : Text("Email: \nTel: "),
               trailing: Row(
                 mainAxisSize: MainAxisSize.min,
                 children:
                 [
                   const VerticalDivider(),
                   CustomWidgets.customIconButton(
                     func: (){
                       ///////////////////////////////////////
                     },
                     icon:Icon(
                       Icons.edit,
                       color: CustomColors.green,
                     ),
                   ),
                   CustomWidgets.customIconButton(
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

 static Widget showProgress(){
   return const Center(
     child: CircularProgressIndicator(),
   );
 }

 static void showSnackBar(context,content,color){
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
          content: Text(
            content,
            style:const TextStyle(
              color: Colors.white
            ),
          ),
          backgroundColor: color,

     )
   );
 }

 static void showAlertDialog(context,Widget children,List<Widget> list){
   showDialog(
       context: context,
       builder: (context) => AlertDialog(
         title:const Text(
           "Ajouter Projet",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             color: Colors.white,
           ),
         ),
         content: children,
         actions: list,
         ),
       );
 }
}