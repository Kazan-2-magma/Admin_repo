
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/UserModel.dart';
import '../CustomColors.dart';

class CustomWidgets{
  static ScaffoldMessengerState? scaffoldMessengerState;

  static void init(BuildContext context) {
    scaffoldMessengerState = ScaffoldMessenger.of(context);
  }




 static Widget customButton({
   required String text,
   required VoidCallback func,
   Color colorText = Colors.white,
   Color color =  Colors.green,
   Color? shadowColor,
   Color? surfaceTintColor,
   Color borderColor = Colors.transparent,
   double borderWidth = 0,
   Icon? icon,
   double radius = 10.0,
   double elevation = 0,
   double textSize =18,
}){
   return ElevatedButton(
     onPressed: func,
     style: ElevatedButton.styleFrom(
       backgroundColor: color,
       surfaceTintColor: surfaceTintColor,
       foregroundColor: colorText,
       shadowColor: shadowColor,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(radius),
         side: BorderSide(
           color: borderColor,
           width: borderWidth,
         ),
       ),
     ),
     child: Text(
         text,
     style: TextStyle(fontSize: textSize),),

   );
 }


 static Widget customButtonWithIcon({
   required String text,
   required VoidCallback func,
   double radius = 10.0,
   Color? color,
   IconData? icon,
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

 void printt(){
    print("hehehehe");
 }

 static Widget customTextFormField({
   BuildContext? context,
   required String? Function(String?)? funcValid,
   required TextEditingController? editingController,
   required String? hintText,
   bool isObscureText = false,
   String? initValue,
   IconData? icon,
   Color? iconColor = Colors.blue,
   Color? colorText = Colors.blue,
   Color? fillColor = Colors.white,
   Color borderColor = Colors.blue,
   filled = true,
   IconButton? suffixIcon,
   Icon? prefix,
   TextInputType? inputType,

}){
   return TextFormField(
     initialValue: initValue,
     validator:funcValid,
     keyboardType: inputType,
     controller: editingController,
     decoration: InputDecoration(
       suffixIcon: suffixIcon,
       prefix: prefix,
       fillColor: fillColor,
       filled: true,
       labelStyle: TextStyle(
         color: colorText,
       ),
       labelText: hintText,
       enabledBorder: OutlineInputBorder(
         borderSide: BorderSide(
           color: borderColor,
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

 static Widget customCardUser(UserModel user,{bool checkbox = false,bool isUser = false}) => Card(
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
       child:ListTile(
             contentPadding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
             title: Text(
               "${user.firstName} ${user.lastName}",
               style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),
             ),
             subtitle:isUser
                 ? Text("Email: ${user.email}\nTel: ${user.phoneNumber}")
                 : Text("Email: ${user.email}\nTel: ${user.phoneNumber}\nRole : ${user.role}"),
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

                   },
                   icon:Icon(
                     Icons.delete,
                     color: CustomColors.red,
                   ),
                 ),
               ],
             )
       )
     ),
   ),
 );
 static Widget customCardProjet(Map<String,dynamic> data,
     {Function(String?)? deleteFunction}) => Card(
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
       child: ListTile(
           contentPadding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
           title: Text(
             data["nomProjet"],
             style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),
           ),
           subtitle:Text("Email: ${data["email_professionel"]}\nTel: ${data["phoneNumber"]}"),
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
                   if(deleteFunction != null && data["id"] != null) {
                      deleteFunction(data["id"]);
                   }
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
   scaffoldMessengerState?.showSnackBar(
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

 static void showAlertDialog(context,String titleText,{Widget? children,List<Widget>? list}){
   showDialog(
       context: context,
       builder: (context) => AlertDialog(
         actionsAlignment: MainAxisAlignment.center,
         surfaceTintColor: CustomColors.white,
         backgroundColor: CustomColors.white,
         elevation: 4,
         shadowColor: CustomColors.black,
         title:Text(
           textAlign: TextAlign.center,
           titleText,
           style: TextStyle(
             fontWeight: FontWeight.bold,
             color: CustomColors.blue
           ),
         ),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(11),
           side: BorderSide(
             color: CustomColors.blue,
             width: 2,
           ),
         ),
         content: children,
         actions: list,
         ),
       );
 }


}