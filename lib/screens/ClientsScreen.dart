

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/data_verification/email_password_verification.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceClients.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/Client.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/UserModel.dart';
import '../model/Users.dart';

class ClientsScreen extends StatefulWidget {
  final FirebaseServiceClients _firebaseServiceClients = FirebaseServiceClients();
  final FirebaseServiceProject _firebaseServiceProject = FirebaseServiceProject();
  AdminUser? adminUser;
  ClientsScreen({super.key, this.adminUser});
  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}


class _ClientsScreenState extends State<ClientsScreen> {
  TextEditingController dropDownSearchTextEditingController = TextEditingController();
  List<Map<String,dynamic>> projectsList = [];
  Future<List<Client>?>? clientsList;
  TextEditingController _searchController = TextEditingController(),
      firstName = TextEditingController(),
      lastName = TextEditingController(),
      phoneNumber = TextEditingController(),
      email = TextEditingController();
  String? selectedProjectId;
  List<String> list = ["jfd","ddf"];

  @override
  void initState(){
    super.initState();
    fetchData();
    clientsList =  widget._firebaseServiceClients.getClients();
  }
  void fetchData() async{
    projectsList = await widget._firebaseServiceProject.getProjects();
    projectsList.forEach((element) {
      print(element["id"]);
    });
  }

  @override
  Widget build(BuildContext context){
    CustomWidgets.init(context);
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
                            DropdownButton<String>(
                                value: selectedProjectId,
                                items: projectsList!.map((e){
                                  return DropdownMenuItem<String>(
                                      value: e["id"],
                                      child: Text(e["nomProjet"])
                                  );
                                }).toList(),
                                onChanged: (value){
                                  setState((){
                                    selectedProjectId = value;
                                  });
                                  print(value);
                                }

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
                        FutureBuilder(
                          future: clientsList,
                          builder: (context,snapshot){
                             if(snapshot.connectionState == ConnectionState.waiting){
                               return const Center(
                                 child: CircularProgressIndicator(),
                               );
                             }
                             else if(snapshot.hasData){
                               var data = snapshot.data;
                               return Expanded(
                                 child: ListView.separated(
                                      separatorBuilder: (context,index) => const SizedBox(height:10.0),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context,index){
                                        return Card(
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
                                                    data![index].getFullName(),
                                                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900),
                                                  ),
                                                  subtitle:Text("Email ${data[index].email}\nTel\n${data[index].phoneNumber}"),
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
                                                          widget._firebaseServiceClients.deleteClient(data[index].id)
                                                              .then((value){
                                                                CustomWidgets.showSnackBar(
                                                                    context,
                                                                    "Success !! Client est supprimer",
                                                                    Colors.green
                                                                );
                                                          });
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
                                      },
                                 ),
                               );
                             }else{
                               return const Center(
                                 child: Text(
                                   "No Client"
                                 ),
                               );
                             }
                          },
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
                                "Ajouter Client",
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
                              if(value!.isEmpty) return "Entre le nom de Client";
                              return null;
                            },
                            editingController: firstName,
                            hintText: "Prenom de Client",

                          ),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.customTextFormField(
                            icon: Icons.person,

                            funcValid: (value){
                              if(value!.isEmpty) return "Entre le nom de Client";
                              return null;
                            },
                            editingController: lastName,
                            hintText: "Nom de Client",

                          ),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.customTextFormField(
                            icon: Icons.email,
                            inputType: TextInputType.emailAddress,
                            funcValid: (value){
                              if(value!.isEmpty) return "Entre le Email de Client";
                              else if(!emailValidation(value)){
                                return "Email n'est pas valid";
                              }
                              return null;
                            },
                            editingController: email,
                            hintText: "Email de Client",
                          ),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.customTextFormField(
                            icon: Icons.call,
                            inputType: TextInputType.number,
                            funcValid: (value){
                              if(value!.isEmpty) return "N° de Telephone de Client";
                              else if(phoneNumberValidation(value)){
                                return "N° d Telephone n'est pas valide";
                              }
                              return null;
                            },
                            editingController: phoneNumber,
                            hintText: "N° Telephone de Client",
                          ),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.verticalSpace(20.0),
                          CustomWidgets.verticalSpace(20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                            [
                              Flexible(
                                  child: CustomWidgets.customButton(
                                      text: "Ajouter",
                                      func: (){
                                        if(formKey.currentState!.validate()) {
                                            widget._firebaseServiceClients.addClient(
                                              Client(
                                                  firstName: firstName.text,
                                                  lastName: lastName.text,
                                                  email: email.text,
                                                  phoneNumber: phoneNumber.text
                                              )
                                            ).then((value){
                                              print("Client added");
                                              CustomWidgets.showSnackBar(
                                                  context,
                                                  "Client est Ajouter",
                                                  CustomColors.green
                                              );
                                              setState;
                                              Navigator.pop(context);
                                            }).catchError((onError){
                                              print(onError.toString());
                                            });
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
}
