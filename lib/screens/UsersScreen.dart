

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/data_verification/email_password_verification.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/widgets.dart';

import '../model/UserModel.dart';
import '../model/Users.dart';
import '../twilio/twilio.dart';

class UsersScreen extends StatefulWidget {
  final FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();
  final FirebaseServiceProject _firebaseServiceProject = FirebaseServiceProject();
  AdminUser? adminUser;
  UsersScreen({super.key, this.adminUser});
  @override
  State<UsersScreen> createState() => _UsersScreenState();
}



class _UsersScreenState extends State<UsersScreen> {
  TextEditingController dropDownSearchTextEditingController = TextEditingController();

  bool isVisible = true;
  bool isVisibleConf = true;
  bool isSending = false;
  Stream<List<UserModel>>? usersList;
  List<Map<String,dynamic>>? projectsList;
  TextEditingController _searchController = TextEditingController(),
      firstName = TextEditingController(),
      lastName = TextEditingController(),
      phoneNumber = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController(),
      confirmPassword = TextEditingController(),
      role = TextEditingController();
      String? selectedProjectId;
  List<bool> checkBoxes = [];
  int length = 0;
  bool isCheck = false;

  @override
  void initState(){
    super.initState();
    usersList = widget._firebaseServiceUser.getUsers();
    fetchProjectsData();
  }
  void fetchProjectsData() async{
    projectsList =await widget._firebaseServiceProject.getProjects();
    print(projectsList);
  }


  @override
  Widget build(BuildContext context){
    CustomWidgets.init(context);
    var dropMenuValue;
    TextEditingController dropDownSearchBarController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top:5),
        color: CustomColors.lightGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0
          ),
          child: Stack(
            children:
            [
              if(isSending)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 70
                ),
                child: Column(
                  children:
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                      [
                        Flexible(
                          child: AnimationSearchBar(
                            searchBarWidth: MediaQuery.of(context).size.width - 70,
                            isBackButtonVisible: false,
                            centerTitle: "List Des Utilisateurs : ",
                            centerTitleStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                            hintText: "Chercher un client...",
                            onChanged: (String) {

                            },
                            searchTextEditingController: _searchController,
                          ),
                        ),
                        CustomWidgets.customIconButton(
                            color: CustomColors.green,
                            func: (){
                              BottomSheet("");
                            },
                            icon:const Icon(
                                Icons.add_business_rounded
                            )
                        )
                      ],
                    ),
                    const Divider(),
                    StreamBuilder(
                        stream: usersList,
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }else if(snapshot.hasData ){
                            checkBoxes = List<bool>.filled(snapshot.data!.length,false);
                            return Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context,index) => CustomWidgets.verticalSpace(10.0),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context,index){
                                    UserModel user =  snapshot.data![index].role == "admin"
                                        ? snapshot.data![index] as AdminUser
                                        : snapshot.data![index] as Users;
                                    return StatefulBuilder(
                                      builder: (context,setState){
                                        return CustomWidgets.customCardUser(
                                            user,
                                            isCheck: checkBoxes[index],
                                            func: (value){
                                              setState((){
                                                checkBoxes[index] = value!;
                                              });
                                            }
                                        );
                                      },
                                    );
                                  },
                                )
                            );
                          }else{
                            return const Center(
                              child: Text(
                                "No Clients Found",
                                style:TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          }
                        }
                    )
                  ],
                    ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: CustomWidgets.customButtonWithIcon(
                      text: "Envoyer",
                      func: (){
                        //selectedUser()
                        showOptions(context);
                        },
                      color: CustomColors.green,
                      icon: Icons.send
                  ),
              ),
            ],
          )
          )
        ),
    );
  }

  void BottomSheet(String user_id){
    var formKey = GlobalKey<FormState>();
    var groupValue = "user";
    showBottomSheet(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context,setState){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.98,
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                            [
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon:const Icon(Icons.arrow_back_ios)),
                              const Text(
                                "Ajouter Utilisateurs",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30.0,
                                ),
                              ),
                            ],
                          ),
                          CustomWidgets.customTextFormField(
                            icon: Icons.person,
                            funcValid: (value){
                              if(value!.isEmpty) return "Entre le nom de Utilisateur";
                              return null;
                            },
                            editingController: firstName,
                            hintText: "Prenom de Utilisateur",

                          ),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.customTextFormField(
                            icon: Icons.person,

                            funcValid: (value){
                              if(value!.isEmpty) return "Entre le nom de Utilisateur";
                              return null;
                            },
                            editingController: lastName,
                            hintText: "Nom de Utilisateur",

                          ),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.customTextFormField(
                            icon: Icons.email,

                            inputType: TextInputType.emailAddress,
                            funcValid: (value){
                              if(value!.isEmpty) return "Entre le Email de Utilisateur";
                              else if(!emailValidation(value)){
                                return "Email n'est pas valid";
                              }
                              return null;
                            },
                            editingController: email,
                            hintText: "Email de Utilisateur",
                          ),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.customTextFormField(
                            icon: Icons.call,
                            inputType: TextInputType.phone,
                            funcValid: (value){
                              if(value!.isEmpty) return "N° de Telephone de Utilisateur";
                              else if(!phoneNumberValidation(value)){
                                return "N° de Telephone n'est valid";
                              }
                              return null;
                            },
                            editingController: phoneNumber,
                            hintText: "N° Telephone de Utilisateur",
                          ),
                          CustomWidgets.verticalSpace(20.0),

                          Row(
                            children:
                            [
                              Expanded(
                                  child: RadioListTile(
                                    title: Text("Admin"),
                                    value: "Admin",
                                    onChanged: (value){
                                      setState((){
                                        groupValue = value!;
                                      });
                                    },
                                    groupValue: groupValue,
                                  )
                              ),
                              Flexible(
                                child: RadioListTile(
                                  title:const Text(
                                    "Partenaire",
                                    style: TextStyle(
                                        fontSize: 15.0
                                    ),
                                  ),
                                  value: "partenaire",
                                  onChanged: (value){
                                    setState((){
                                      groupValue = value!;
                                    });
                                  },
                                  groupValue: groupValue,
                                ),
                              ),
                            ],
                          ),
                          if(groupValue == "partenaire")
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                        "Projet : ",
                                        style: TextStyle(fontSize: 21,fontWeight: FontWeight.w800),
                                      )),
                                  DropdownButton<String>(
                                      value: selectedProjectId,
                                      items: projectsList!.map((e){
                                        print(e["id"]);
                                        return DropdownMenuItem<String>(
                                            value: e["id"],
                                            child: Text(e["nomProjet"])
                                        );
                                      }).toList(),
                                      onChanged: (value){
                                          setState((){
                                            selectedProjectId = value!;
                                          });
                                          print(value);
                                      }
                                  )
                                ],
                              ),
                            ),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.customTextFormField(
                            icon: Icons.lock,

                            inputType: TextInputType.visiblePassword,
                            isObscureText: isVisible,
                            suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    isVisible = !isVisible;
                                    print(isVisible);
                                  });
                                },
                                icon : isVisible ? const Icon(Icons.visibility_off,color: Colors.blue,) : const Icon(Icons.visibility,color: Colors.blue)
                            ),
                            funcValid: (value){
                              if(value!.isEmpty) return "Enter Mot de pass de Utilisateur";
                              else if(passwordValidation(value)){
                                return "Mot de pass n'est pas valid";
                              }
                              return null;
                            },
                            editingController: password,
                            hintText: "Mot de pass de Utilisateur",
                          ),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.customTextFormField(
                            icon: Icons.lock,

                            inputType: TextInputType.visiblePassword,
                            isObscureText: isVisibleConf,
                            suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    print("set");
                                    isVisibleConf = !isVisibleConf;
                                  });
                                },
                                icon : isVisibleConf ? const Icon(Icons.visibility_off,color: Colors.blue) : const Icon(Icons.visibility,color: Colors.blue)
                            ),
                            funcValid: (value){
                              if(value!.isEmpty) return "Confirmer Mot de pass de Utilisateur";
                              else if(value != password.text) return "Le mot de pass ne match pas";
                              return null;
                            },
                            editingController: confirmPassword,
                            hintText: "Confirmer Mot de pass de Utilisateur",
                          ),
                          CustomWidgets.verticalSpace(20.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                            [
                              Flexible(
                                  child: CustomWidgets.customButton(
                                      text: "Ajouter",
                                      func: (){
                                          if(formKey.currentState!.validate()){
                                            if(selectedProjectId!.isNotEmpty){
                                              widget._firebaseServiceUser.registerWithEmailAndPassword(
                                                  email.text,
                                                  password.text,
                                                  groupValue == "admin"
                                                      ? AdminUser(
                                                      firstName: firstName.text,
                                                      lastName: lastName.text,
                                                      phoneNumber: phoneNumber.text,
                                                      email: email.text,
                                                      photoUrl: "",
                                                      role: groupValue,
                                                      password: password.text
                                                  )
                                                      : Users(
                                                      firstName: firstName.text,
                                                      lastName: lastName.text,
                                                      phoneNumber: phoneNumber.text,
                                                      email: email.text,
                                                      photoUrl: "",
                                                      role: groupValue,
                                                      password: password.text,
                                                      idProjet: selectedProjectId ?? ""
                                                  )
                                              ).then((value){
                                                CustomWidgets.showSnackBar(
                                                  context,
                                                  "Success! Utilsateur est Ajouter",
                                                  Colors.green,
                                                );
                                                Navigator.pop(context);
                                              }).catchError((e){
                                                CustomWidgets.showSnackBar(
                                                  context,
                                                  "Error d'ajouter cette Utilisateur",
                                                  Colors.red,
                                                );
                                              });
                                            }else{
                                              CustomWidgets.showSnackBar(
                                                context,
                                                "Choisi un projet",
                                                Colors.red,
                                              );
                                            }
                                          }

                                      },
                                      color: CustomColors.green
                                  )
                              ),
                              CustomWidgets.customButton(
                                  text: "Annuler",
                                  color: CustomColors.red,
                                  func: (){
                                    Navigator.pop(context);
                                  }
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
          );
        }
    );
  }

  Future<void> selectedUser() async {
    Stream<List<UserModel>> userStream = widget._firebaseServiceUser.getUsers();
    List<UserModel> userList = await userStream.first;
    for(int i=0;i<userList.length;i++){
      if(checkBoxes[i]){
        String phoneNumberWithCountryCode = modifyPhoneNumber(userList[i].phoneNumber);
        //SMS Code
      }
    }


  }

  List<String> emails = [];


  Future showOptions(context) async {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            title:const Text(
              "Selectioner La methode S'il vous plâit",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13
              ),
            ),
            actions: [
              CupertinoActionSheetAction(
                child:const Text(
                  'SMS',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoActionSheetAction(
                child:const Text(
                  'EMAIL',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: ()async {
                  List<String> selectedEmails = await selectedUsersEmails();
                  launchEmail(selectedEmails);
                  Navigator.of(context).pop();
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child:const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
            ),
        );
    }


  String modifyPhoneNumber(String phoneNumber){
    return phoneNumber.replaceRange(0,1, "+212");
  }

  dynamic launchEmail(List<String> paths) async {
    try
    {

        print(emails);
        Uri email = Uri(
        scheme: 'mailto',
        path:paths.join(","),
        queryParameters: {
          'subject': "",
        },
      );
      await launchUrl(email);


    }
    catch(e) {
      debugPrint(e.toString());
    }
  }

  Future<List<String>> selectedUsersEmails()async{
    List<String> list = [];
    Stream<List<UserModel>> userStream = widget._firebaseServiceUser.getUsers();
    List<UserModel> userList = await userStream.first;
    for(int i=0;i<userList.length;i++){
      if(checkBoxes[i]){
        list.add(userList[i].email);
        print(userList[i].email);
      }
    }
    return list;

  }


}
