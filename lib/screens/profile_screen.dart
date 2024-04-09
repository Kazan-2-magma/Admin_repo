import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/UserModel.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:cinq_etoils/shared/image_functions/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  AdminUser? adminUser;
  User? user = FirebaseAuth.instance.currentUser;
  ProfileScreen({this.adminUser});
  FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _imageStr;
  XFile? _imageProfile;
  XFile? _image;
  final picker = ImagePicker();
  var editNom = TextEditingController(),editPhone = TextEditingController(),editEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.adminUser!.photoUrl.isNotEmpty){
      //_image = convertStringToXFile(widget.adminUser!.photoUrl);
    }
    print("From profile admin : ${widget.adminUser}");
  }
  @override
  Widget build(BuildContext context) {

  return Scaffold(
      body: Center(
        child: Container(
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          color: CustomColors.lightGrey,
          padding: EdgeInsets.symmetric(horizontal: 7.0, vertical:20),
          child: Column(
            children:
            [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.grey,
                      spreadRadius: 0,
                      offset: const Offset(1.5, 1.5),
                    ),
                  ],
                ),
                child: Column(
                  children:
                  [
                    Container(
                      padding: EdgeInsets.symmetric( horizontal:20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  getImageFromGallery();
                                },
                                child: _image != null
                                    ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage : FileImage(File(_image!.path)),)
                                    : ProfilePicture(
                                        //IMAGE
                                        radius: 50,
                                        name: widget.adminUser!.getFullname(),
                                        fontsize: 21,
                                        img: _imageStr,
                                ),
                              ),
                              CustomWidgets.horizontalSpace(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.adminUser!.firstName} ${widget.adminUser!.lastName}",
                                    style:const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_pin_rounded,color: CustomColors.grey,size: 15,),
                                      Text(
                                        textAlign: TextAlign.start,
                                        widget.adminUser!.role,
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
                    const Divider(height: 1.0,indent: 45,),
                    Container(
                      height: 50,
                      padding:const EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
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
                                    "${widget.adminUser!.lastName} ${widget.adminUser!.firstName}",
                                    style:const TextStyle(fontWeight: FontWeight.w600),
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

                    const Divider(height: 1.0,indent: 45),
                    Container(
                      height: 50,
                      padding:const EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
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
                                style:const TextStyle(fontWeight: FontWeight.w600),
                                widget.adminUser!.phoneNumber
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

                    const Divider(height: 1.0,indent: 45,),
                    Container(
                      height: 50,
                      padding:const  EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
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
                                widget.adminUser!.email,
                                style:const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                    const Divider(height: 1.0,indent: 45,),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
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
                                    style:const TextStyle(fontWeight: FontWeight.w600),
                                    widget.adminUser!.role
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
                            text: "Deconnecter",
                            func: (){
                                widget._firebaseServiceUser.signOut();
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




//Photo
  Future<void> getImageFromGallery() async {
    await picker.pickImage(source: ImageSource.gallery)
        .then((value) async {
          if(value != null){
            setState(() {
              _image = XFile(value.path);
            });
            widget.adminUser!.photoUrl = await convertXFileIntoBase64()!;
            widget._firebaseServiceUser.modifyUserById(
                widget.user!.uid,
                widget.adminUser as AdminUser
            );
            print(widget.adminUser);
          }
    }).catchError((e){
      print(e.toString());
    });
  }
//Image to base64
  Future<String>? convertXFileIntoBase64() async {
    String converter = "";
    if(_image != null){
      Uint8List bytes = await _image!.readAsBytes();
      converter = base64Encode(bytes);
    }
    return converter;
  }

  MemoryImage? convertStringToXFile(String imageString)  {
    try {
      Uint8List bytes = base64Decode(imageString);
      return MemoryImage(bytes);
    }catch (e) {
      print('Error converting string to XFile: $e');
      return null;
    }
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
