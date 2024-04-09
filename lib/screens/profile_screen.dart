import 'dart:convert';
import 'dart:typed_data';

import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _image;
  XFile? _imageProfile;
  var editNom = TextEditingController(),editPhone = TextEditingController(),editEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {

  return Scaffold(
      body: Center(
        child: Container(
          color: CustomColors.lightGrey,
          padding: EdgeInsets.symmetric(horizontal: 7.0, vertical:20),
          child: Column(
            children:
            [
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.grey,
                      spreadRadius: 0,
                      offset: Offset(1.5, 1.5),
                    ),
                  ],
                ),
                height: 490,
                child: Column(
                  children:
                  [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal:20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Row(
                            children: [
                              GestureDetector(
                                child: _imageProfile != null
                                    ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage : _imageProfile as ImageProvider,
                                )
                                    : ProfilePicture(
                                        //IMAGE
                                        radius: 50,
                                        name: 'name name',
                                        fontsize: 21,
                                        img: _image,
                                ),
                                onTap: (){

                                },
                              ),
                              CustomWidgets.horizontalSpace(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "name name", /////////////////// nom et prenome
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_pin_rounded,color: CustomColors.grey,size: 15,),
                                      Text(
                                        textAlign: TextAlign.start,
                                        "Role",
                                        style: TextStyle(
                                          color: CustomColors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          //BUTTON DYAL EDIT PHOTO
                          // Container(
                          //   width: 110,
                          //   child: CustomWidgets.customButton(
                          //       text: 'Edit photo',
                          //       func: () {
                          //         // yassine ha hiya l botona 7ta t9adha
                          //       },
                          //       color: CustomColors.transparent,
                          //       shadowColor: CustomColors.transparent,
                          //       surfaceTintColor: CustomColors.transparent,
                          //       colorText: CustomColors.grey,
                          //       radius: 30,
                          //       borderColor: CustomColors.grey,
                          //       borderWidth: 1.2,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    ////////////////////////////////       nome et prenome
                    Divider(height: 1.0,indent: 45,),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                        [
                          Row(
                            children: [
                              Icon(Icons.person,size: 30,color: CustomColors.grey,),
                              CustomWidgets.horizontalSpace(10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nom",style: TextStyle(color: CustomColors.grey),),
                                  Text(
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                    "Adolf Hitler"//Nom Data
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomWidgets.customIconButton(
                              func: () {
                                  showTextField("Nom", editNom);
                              },
                              icon: Icon(Icons.edit,color: CustomColors.grey,),
                          )
                        ],
                      ),
                    ),

                    ////////////////////////////////       tele
                    Divider(height: 1.0,indent: 45),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
                      child: Row(
                        children:
                        [
                          Icon(Icons.call,size: 30,color: CustomColors.grey,),
                          CustomWidgets.horizontalSpace(10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Telephone",style: TextStyle(color: CustomColors.grey),),
                              Text(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                "+212 723-3298"//Nom Data
                              ),
                            ],
                          ),
                          CustomWidgets.customIconButton(
                            func: () {
                              showTextField("Nom", editNom);
                            },
                            icon: Icon(Icons.edit,color: CustomColors.grey,),
                          )
                        ],
                      ),
                    ),

                    Divider(height: 1.0,indent: 45,),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
                      child: Row(
                        children:
                        [
                          Icon(Icons.email,size: 30,color: CustomColors.grey,),
                          CustomWidgets.horizontalSpace(10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email",style: TextStyle(color: CustomColors.grey),),
                              Text(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                "AdolfHitler007@NaziForever.Germany"//Nom Data
                              ),
                            ],
                          )

                        ],
                      ),
                    ),

                    ////////////////////////////////        role
                    Divider(height: 1.0,indent: 45,),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                        [
                          Row(
                            children: [
                              Icon(Icons.person_pin_rounded,size: 30,color: CustomColors.grey,),
                              CustomWidgets.horizontalSpace(10),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Role",style: TextStyle(color: CustomColors.grey),),
                                  Text(
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                    "Hokage"//Nom Data
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomWidgets.customIconButton(
                            func: () {  },
                            icon: Icon(Icons.edit,color: CustomColors.grey,),
                          )

                        ],
                      ),
                    ),


                    CustomWidgets.verticalSpace(30.0),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: CustomWidgets.customButton(
                              textSize: 16,
                              text: "Modifier le mot de pass",
                              func: (){

                              },
                          ),
                        ),
                        CustomWidgets.customButton(
                            textSize: 16,
                            color: CustomColors.red,
                            text: "Deconnecter",// li 3endo m3a fronci ychof m3a hadi
                            func: (){

                            },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showTextField(String title,TextEditingController controller){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(title),
            content: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
            ),
            actions:
            [
              CustomWidgets.customButton(
                  text: 'Modifier',
                  func: (){

                  }
              ),
              CustomWidgets.customButton(
                  text: 'Annuler',
                  func: (){

                  }
              ),
            ],
          );
        }
    );
  }
}
