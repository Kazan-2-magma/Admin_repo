import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/UserModel.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/CustomFunctions.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
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
  XFile? _image;
  final picker = ImagePicker();
  var editNom = TextEditingController(),editPhone = TextEditingController(),editEmail = TextEditingController();

  TextEditingController nomEditEditingController =TextEditingController();
  TextEditingController numeroEditEditingController =TextEditingController();
  TextEditingController currentPasswordEditEditingController =TextEditingController();
  TextEditingController passwordEditEditingController =TextEditingController();
  TextEditingController passwordConfirmationEditEditingController =TextEditingController();
  bool passwordVisible = true;
  Map<String, dynamic>? data;


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async{
    data = await widget._firebaseServiceUser.getUserInfo(widget.adminUser!.id_user);
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
          child: SingleChildScrollView(
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
                  child: SingleChildScrollView(
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
                                        backgroundImage : FileImage(File(_image!.path)),
                                      )
                                        : widget.adminUser!.photoUrl.isNotEmpty
                                        ? CircleAvatar(
                                          radius: 60,
                                          backgroundImage: MemoryImage(base64Decode(widget.adminUser!.photoUrl)),
                                      )
                                        : ProfilePicture(
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
                                        widget.adminUser!.getFullname(),
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        const Divider(height: 0.0,indent: 45,),
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
                                        widget.adminUser!.getFullname(),
                                        style:const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CustomWidgets.customIconButton(
                                  func: () {
                                      CustomWidgets.showAlertDialog(
                                          context,
                                          "Votre nom: ${widget.adminUser!.getFullname()}",
                                          children:  CustomWidgets.customTextFormField(

                                              icon: Icons.person,
                                              funcValid: (value){
                                                return null;
                                              },
                                              editingController: nomEditEditingController,
                                              hintText: "Nouveau nom"),
                                          list:
                                          [
                                            CustomWidgets.customButton(
                                            text: "Sauvgarder",
                                            func: (){
                                              if(nomEditEditingController.text.isNotEmpty){
                                               setState(() {
                                                 data?["firstName"] = splitFullName(nomEditEditingController.text)[0];
                                                 data?["lastName"] = splitFullName(nomEditEditingController.text)[1];
                                               });
                                                print(data!["lastName"]);

                                              }
                                              widget._firebaseServiceUser.modifyUserById(
                                                  widget.adminUser!.id_user,
                                                  AdminUser.fromJson(data)
                                              );
                                              setState(() {
                                                widget.adminUser!.setFullName(nomEditEditingController.text);
                                                Navigator.pop(context);
                                                CustomFunctions.ClearTextFields([nomEditEditingController]);
                                              });
                                            },
                                            color: CustomColors.green,
                                              shadowColor: CustomColors.transparent,
                                              surfaceTintColor: CustomColors.transparent,
                                            colorText: CustomColors.white,
                                            radius: 30,
                                          ),
                                            CustomWidgets.customButton(
                                              text: "Annuler",
                                              func: (){
                                                Navigator.pop(context);
                                                setState(() {
                                                  CustomFunctions.ClearTextFields([nomEditEditingController]);
                                                });
                                              },
                                              color: CustomColors.red,
                                              shadowColor: CustomColors.transparent,
                                              surfaceTintColor: CustomColors.transparent,
                                              colorText: CustomColors.white,
                                              radius: 30,
                                            ),
                                          ]
                                      );
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
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children:
                            [
                              Row(
                                children: [
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
                                ],
                              ),
                              CustomWidgets.customIconButton(
                                func: () {
                                  CustomWidgets.showAlertDialog(
                                      context,
                                      "Votre Tel: ${widget.adminUser!.phoneNumber}",
                                      children: CustomWidgets.customTextFormField(
                                        icon: Icons.call,
                                          funcValid: (value){
                                              return null;
                                          },
                                          editingController: numeroEditEditingController,
                                          hintText: "Nouvell numero"),
                                      list: [
                                        CustomWidgets.customButton(
                                          text: "Sauvgarder",
                                          func: (){
                                            if(numeroEditEditingController.text.isNotEmpty){
                                              data!["phoneNumber"] = numeroEditEditingController.text;
                                            }
                                            widget._firebaseServiceUser.modifyUserById(
                                                widget.adminUser!.id_user,
                                                AdminUser.fromJson(data)
                                            );
                                            setState(() {
                                              widget.adminUser!.phoneNumber = numeroEditEditingController.text;
                                              Navigator.pop(context);
                                              CustomFunctions.ClearTextFields([nomEditEditingController]);
                                            });
                                          },
                                          color: CustomColors.green,
                                          shadowColor: CustomColors.transparent,
                                          surfaceTintColor: CustomColors.transparent,
                                          colorText: CustomColors.white,
                                          radius: 30,
                                        ),
                                        CustomWidgets.customButton(
                                          text: "Annuler",
                                          func: (){
                                            Navigator.pop(context);
                                            setState(() {
                                              CustomFunctions.ClearTextFields([numeroEditEditingController]);
                                            });
                                          },
                                          color: CustomColors.red,
                                          shadowColor: CustomColors.transparent,
                                          surfaceTintColor: CustomColors.transparent,
                                          colorText: CustomColors.white,
                                          radius: 30,
                                        ),
                                      ]
                                  );
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
                                    var formKey = GlobalKey<FormState>();
                                    CustomWidgets.showAlertDialog(
                                        context,
                                        "Modifier mot de pass",
                                        children : StatefulBuilder(
                                          builder : (context,setState){
                                            return  Form(
                                              key: formKey,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children:
                                                  [
                                                    CustomWidgets.customTextFormField(
                                                        inputType: TextInputType.visiblePassword,
                                                        icon: Icons.lock,
                                                        funcValid: (value){
                                                          if(value!.isEmpty) return "Entrer mot de pass";
                                                          else if(value != data!["password"]){
                                                            return "Le mot de pass incorrect";
                                                          }
                                                          return null;
                                                        },
                                                        isObscureText: passwordVisible,
                                                        suffixIcon: IconButton(
                                                          icon: passwordVisible
                                                              ? Icon(Icons.visibility_off)
                                                              : Icon(Icons.visibility),
                                                          color: CustomColors.blue,
                                                          onPressed: () {
                                                            setState(() {
                                                              print("State Changed");
                                                              passwordVisible = !passwordVisible;
                                                            },
                                                            );
                                                          },
                                                        ),
                                                        editingController: currentPasswordEditEditingController,
                                                        hintText: "Mot de pass"),
                                                    CustomWidgets.verticalSpace(20.0),
                                                    CustomWidgets.customTextFormField(
                                                        icon: Icons.lock_open,
                                                        funcValid: (value){
                                                          if(value!.isEmpty) {
                                                            return "Entrer la Nouvelle de mot de pass";
                                                          }
                                                          return null;
                                                        },
                                                        isObscureText: passwordVisible,
                                                        editingController: passwordEditEditingController,
                                                        hintText: "Nouvell mot de pass"),
                                                    CustomWidgets.verticalSpace(20.0),
                                                    CustomWidgets.customTextFormField(
                                                        icon: Icons.lock_open,
                                                        funcValid: (value){
                                                          if(value!.isEmpty) {
                                                            return "Entrer la Confirmation de mot de pass";
                                                          } else if(value != passwordEditEditingController.text){
                                                            return "Le mot de pass ne match pas";
                                                          }
                                                          return null;
                                                        },
                                                        isObscureText: passwordVisible,
                                                        editingController: passwordConfirmationEditEditingController,
                                                        hintText: "Confirmer mot de pass"),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        ),
                                        list:
                                        [
                                          Flexible(
                                            child: CustomWidgets.customButton(
                                              text: "Sauvgarder",
                                              func: (){
                                                if(formKey.currentState!.validate()) {
                                                  widget._firebaseServiceUser.reAuthenticateUser(
                                                      widget.adminUser!.email,
                                                      currentPasswordEditEditingController.text,
                                                  ).then((_){
                                                    widget._firebaseServiceUser.updatePassword(
                                                        widget.adminUser!.id_user,
                                                        passwordEditEditingController.text,
                                                    ).then((value){
                                                      print("Password updated");
                                                      Navigator.pop(context);
                                                    }).catchError((onError){
                                                      print("Update error");
                                                    });
                                                  }).catchError((onError){
                                                    print("Auth error");
                                                  });
                                                }
                                              },
                                              color: CustomColors.green,
                                              shadowColor: CustomColors.transparent,
                                              surfaceTintColor: CustomColors.transparent,
                                              colorText: CustomColors.white,
                                              radius: 30,
                                            ),
                                          ),
                                          Flexible(
                                            child: CustomWidgets.customButton(
                                              text: "Annuler",
                                              func: (){
                                                Navigator.pop(context);
                                                setState(() {
                                                  CustomFunctions.ClearTextFields([nomEditEditingController]);
                                                });
                                              },
                                              color: CustomColors.red,
                                              shadowColor: CustomColors.transparent,
                                              surfaceTintColor: CustomColors.transparent,
                                              colorText: CustomColors.white,
                                              radius: 30,
                                            ),
                                          ),
                                        ]
                                        );
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
                  ),
                )
              ],
            ),
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
  
  splitFullName(String fullName){
    var fullNameSplitted = (fullName.contains(" ")) ? fullName.split(" ") : fullName;
    return fullNameSplitted;
  }
}
