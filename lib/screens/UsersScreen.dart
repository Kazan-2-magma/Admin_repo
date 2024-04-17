

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
import 'package:flutter/widgets.dart';

import '../model/UserModel.dart';
import '../model/Users.dart';

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

  @override
  void initState(){
    super.initState();
    usersList = widget._firebaseServiceUser.getUsers();
    fetchProjectsData();
  }
  void fetchProjectsData() async{
    projectsList =await widget._firebaseServiceProject.getProjects();
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
              Column(
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
                          return Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context,index) => CustomWidgets.verticalSpace(10.0),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context,index){
                                  UserModel user =  snapshot.data![index].role == "admin"
                                      ? snapshot.data![index] as AdminUser
                                      : snapshot.data![index] as Users;
                                  return CustomWidgets.customCardUser(user,borderSideColor: CustomColors.blue);
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
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: CustomWidgets.customButtonWithIcon(
                      text: "Envoyer",
                      func: (){
                        selectedUser();
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
                              else if(emailValidation(value)){
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

                            inputType: TextInputType.number,
                            funcValid: (value){
                              if(value!.isEmpty) return "N° de Telephone de Utilisateur";
                              else if(phoneNumberValidation(value)){
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
                                      child: Text("Projet : ",style: TextStyle(fontSize: 15),)),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      hint: Text(
                                      'Choisir un projet',
                                      style: TextStyle(
                                      fontSize: 14,
                                      color: CustomColors.grey,
                                      ),
                                      ),
                                      value: selectedProjectId,
                                      items: projectsList?.map((e){
                                        return DropdownMenuItem<String>(
                                            value: e["id"],
                                            child: Text(e["nomProjet"])
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        print(value);
                                        setState((){
                                          selectedProjectId = value;
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      height: 40,
                                      width: 200,
                                      ),
                                      dropdownStyleData: const DropdownStyleData(
                                      maxHeight: 200,
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                      searchController: dropDownSearchTextEditingController,
                                      searchInnerWidgetHeight: 50,
                                      searchInnerWidget: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                      ),
                                      child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: dropDownSearchTextEditingController,
                                      decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                      ),
                                      hintText: 'Chercher un projet...',
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      ),
                                      ),
                                      ),
                                      ),
                                      searchMatchFn: (item, searchValue) {
                                      return item.value.toString().contains(searchValue);
                                      },
                                      ),
                                      //This to clear the search value when you close the menu
                                      onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                      dropDownSearchTextEditingController.clear();
                                      }
                                      },
                                    ),
                                  ),
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
                                                  idProjet: ''
                                              )
                                          ).then((value){
                                            CustomWidgets.showSnackBar(
                                              context,
                                              "Success! Utilsateur est Ajouter",
                                              Colors.green,
                                            );
                                          }).catchError((e){
                                            print("ERROR : ADDING NEW USER");
                                          });
                                        Navigator.pop(context);
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
    userList.forEach((user) {
      print(user.firstName); // Example usage
    });
  }
}
