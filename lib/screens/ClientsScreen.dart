

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/data_verification/email_password_verification.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceAttach.dart';
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
import 'package:url_launcher/url_launcher.dart';

import '../model/UserModel.dart';
import '../model/Users.dart';

class ClientsScreen extends StatefulWidget {
  final FirebaseServiceClients _firebaseServiceClients = FirebaseServiceClients();
  final FirebaseServiceProject _firebaseServiceProject = FirebaseServiceProject();
  final FirebaseServiceAttach _firebaseServiceAttach = FirebaseServiceAttach();
  AdminUser? adminUser;
  ClientsScreen({super.key, this.adminUser});
  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}


class _ClientsScreenState extends State<ClientsScreen> {
  TextEditingController dropDownSearchTextEditingController = TextEditingController();
  List<Map<String,dynamic>> projectsList = [];
  Future<List<Client>?>? clientsList;
  Future<List<Client>>? clientProjects;
  TextEditingController _searchController = TextEditingController(),
      firstName = TextEditingController(),
      lastName = TextEditingController(),
      phoneNumber = TextEditingController(),
      email = TextEditingController();
  String? selectedProjectId;
  List<bool> checkboxes = [];

  @override
  void initState(){
    super.initState();
    fetchProjectData();
    clientsList =  widget._firebaseServiceClients.getClients();
    fetchClientData();
  }

  void fetchProjectData() async{
    projectsList = await widget._firebaseServiceProject.getProjects();
    projectsList.forEach((element) {
    });
  }

  void fetchClientData()async{
    checkboxes = List<bool>.filled(FirebaseServiceClients.countClinents,false);
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
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  CustomWidgets.customIconButton(
                      color: CustomColors.green,
                      func: (){
                        BottomSheet("");
                      },
                      icon:const Icon(
                          Icons.add_business_rounded
                      )
                  ),
                  DropdownButton<String>(
                      menuMaxHeight: 200,
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                        [
                          IconButton(
                          onPressed: (){
                            setState((){
                              if(selectedProjectId == null){
                                //clientsList = widget._firebaseServiceClients.getClientsWithProject(selectedProjectId!);
                                return;
                              }else{
                                clientsList = widget._firebaseServiceClients.getClientsWithProject(selectedProjectId!);
                              }
                              selectedProjectId = null;
                              clientsList = widget._firebaseServiceClients.getClients();
                            });
                          }, icon: Icon(Icons.remove))
                        ],
                      ),
                      hint: Text("Select Projet"),
                      value: selectedProjectId,
                      items: projectsList.map((e){
                        return DropdownMenuItem<String>(
                          value:e["id"],
                          child: Text(e["nomProjet"]),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          selectedProjectId = value!;
                          if(selectedProjectId != null){
                            clientsList = widget._firebaseServiceClients.getClientsWithProject(selectedProjectId!);
                          }
                        });
                      }
                  ),
                ],
                ),

                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 70,
                      top: 40
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
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
                                        return  Card(
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
                                                            updateBottomSheet(data[index],data[index].id);
                                                          },
                                                          icon:Icon(
                                                            Icons.edit,
                                                            color: CustomColors.green,
                                                          ),
                                                        ),
                                                        CustomWidgets.customIconButton(
                                                          func: (){
                                                            showDialog(
                                                                context: context,
                                                                builder: (context)=>AlertDialog(
                                                                  title: Text(
                                                                    "Voulez-vous supprimer cette Client?",
                                                                  ),
                                                                  actions:
                                                                  [
                                                                    ElevatedButton(
                                                                        style : ElevatedButton.styleFrom(
                                                                          backgroundColor: Colors.green,
                                                                          foregroundColor: Colors.white,
                                                                        ),
                                                                        onPressed: (){
                                                                          widget._firebaseServiceClients.deleteClient(
                                                                            data[index].id,
                                                                          ).then((value){
                                                                            CustomWidgets.showSnackBar(
                                                                                context,
                                                                                "Le Client est supprimer",
                                                                                Colors.green
                                                                            );
                                                                            setState(() {
                                                                              clientsList =  widget._firebaseServiceClients.getClients();
                                                                            });
                                                                            AppFunctions.navigateFrom(context);
                                                                          }).catchError((e){
                                                                            print(e.toString());
                                                                          });
                                                                        },
                                                                        child: Text("Oui"),
                                                                    ),
                                                                    ElevatedButton(
                                                                        style : ElevatedButton.styleFrom(
                                                                          backgroundColor: Colors.red,
                                                                          foregroundColor: Colors.white,
                                                                        ),
                                                                        onPressed: (){
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: Text(
                                                                          "Annuler",
                                                                        )
                                                                    )
                                                                  ],
                                                                )
                                                            );
                                                          },
                                                          icon:Icon(
                                                            Icons.delete,
                                                            color: CustomColors.red,
                                                          ),
                                                        ),
                                                        Checkbox(
                                                            value: checkboxes[index],
                                                            onChanged: (value){
                                                              setState(() {
                                                                checkboxes[index] = value!;
                                                              });
                                                              print(checkboxes);

                                                            }
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ),
                                        );
                                      },
                                 ),
                               );
                             }
                             else{
                               return const Center(
                                 child: Text(
                                   "No Clients",
                                   style: TextStyle(
                                     fontSize: 50.0
                                   ),
                                 ),
                               );
                             }
                          },
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 20,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height /16,
                      child: CustomWidgets.customButtonWithIcon(
                          text: "Envoyer",
                          func: (){
                            if(checkboxes.every((element) => element == false)){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Selectioner en moins un client pour Envoyer SMS ou Email"),backgroundColor: Colors.orangeAccent,)
                              );
                            }else{
                              showOptions(context);
                            }

                          },
                          color: CustomColors.green,
                          icon: Icons.send
                      ),
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
    String? client_project;
    showBottomSheet(
        context: context,
        builder: (context){
          return Container(
                  height: MediaQuery.of(context).size.height * 0.98,
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom
                      ),
                      child: StatefulBuilder(
                        builder: (context,setState){
                          return Column(
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
                                inputType: TextInputType.phone,
                                funcValid: (value){
                                  if(value!.isEmpty) return "N° de Telephone de Client";
                                  else if(!phoneNumberValidation(value)){
                                    return "N° d Telephone n'est pas valide";
                                  }
                                  return null;
                                },
                                editingController: phoneNumber,
                                hintText: "N° Telephone de Client",
                              ),
                              CustomWidgets.verticalSpace(20.0),
                              DropdownButton<String>(
                                  menuMaxHeight: 200,
                                  hint: Text("Select Projet"),
                                  value: client_project,
                                  items: projectsList.map((e){
                                    return DropdownMenuItem<String>(
                                      value:e["id"],
                                      child: Text(e["nomProjet"]),
                                    );
                                  }).toList(),
                                  onChanged: (value){
                                    setState(() {
                                      client_project = value!;
                                    });
                                  }
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:
                                [
                                  Flexible(
                                      child: CustomWidgets.customButton(
                                          text: Text("Ajouter"),
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
                                                widget._firebaseServiceAttach.addAttachment(
                                                    client_project!,
                                                    value!
                                                ).whenComplete((){
                                                  CustomWidgets.showSnackBar(
                                                      context,
                                                      "Client est Ajouter",
                                                      CustomColors.green
                                                  );
                                                  setState(() {
                                                    clientsList =  widget._firebaseServiceClients.getClients();
                                                  });
                                                });

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
                                      text: Text("Annuler"),
                                      color: CustomColors.red,
                                      func: (){
                                        Navigator.pop(context);
                                      }
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      )
                    ),
                  ),
                );
              }
          );
        }
  void updateBottomSheet(Client client,String client_id){
    var formKey = GlobalKey<FormState>();
    TextEditingController firstName_up = TextEditingController();
    TextEditingController lastname_up = TextEditingController();
    TextEditingController email_up = TextEditingController();
    TextEditingController phoneNumber_up = TextEditingController();
    firstName_up.text = client.firstName;
    lastname_up.text = client.lastName;
    email_up.text = client.email;
    phoneNumber_up.text = client.phoneNumber;
    showBottomSheet(
        context: context,
        builder: (context){
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
                          "Modifier Client",
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
                        if(value!.isEmpty) return "Modifier le nom de Client";
                        return null;
                      },
                      editingController: firstName_up,
                      hintText: "Prenom de Client",
                    ),
                    CustomWidgets.verticalSpace(20.0),
                    CustomWidgets.customTextFormField(
                      icon: Icons.person,

                      funcValid: (value){
                        if(value!.isEmpty) return "Modifier le nom de Client";
                        return null;
                      },
                      editingController: lastname_up,
                      hintText: "Nom de Client",

                    ),
                    CustomWidgets.verticalSpace(20.0),
                    CustomWidgets.customTextFormField(
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      funcValid: (value){
                        if(value!.isEmpty) return "Modifier le Email de Client";
                        else if(!emailValidation(value)){
                          return "Email n'est pas valid";
                        }
                        return null;
                      },
                      editingController: email_up,
                      hintText: "Email de Client",
                    ),
                    CustomWidgets.verticalSpace(20.0),
                    CustomWidgets.customTextFormField(
                      icon: Icons.call,
                      inputType: TextInputType.phone,
                      funcValid: (value){
                        if(value!.isEmpty) return "N° de Telephone de Client";
                        else if(!phoneNumberValidation(value)){
                          return "N° d Telephone n'est pas valide";
                        }
                        return null;
                      },
                      editingController: phoneNumber_up,
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
                                text: Text("Modifier"),
                                func: (){
                                  if(formKey.currentState!.validate()) {
                                    Client client = Client(
                                        firstName: firstName_up.text,
                                        lastName: lastname_up.text,
                                        email: email_up.text,
                                        phoneNumber: phoneNumber_up.text);
                                    widget._firebaseServiceClients.updateClient(
                                        client_id,
                                        client
                                    ).then((value){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Le Client a été modifier"),backgroundColor: Colors.green,)
                                      );
                                      setState(() {
                                        clientsList = widget._firebaseServiceClients.getClients();
                                      });
                                      AppFunctions.navigateFrom(context);
                                    }).catchError((e){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Error lors de modification. Operation Echoue"),backgroundColor: Colors.red,)
                                      );
                                    });
                                  }
                                },
                                color: CustomColors.green
                            )
                        ),
                        CustomWidgets.customButton(
                            text: Text("Annuler"),
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
              // List<String> selectedEmails = await selectedUsersEmails();
              // launchEmail(selectedEmails);
              // Navigator.of(context).pop();
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

  List<String> emails = [];
  dynamic launchEmail(List<String> paths) async {
    try
    {
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
    List<Client>? clients = await widget._firebaseServiceClients.getClients();
    for(int i=0;i<clients!.length;i++){
      if(checkboxes[i]){
        list.add(clients[i].email);
        print(list);
      }
    }
    return list;

  }

}
