//
// import 'package:animation_search_bar/animation_search_bar.dart';
// import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
// import 'package:cinq_etoils/model/project_model.dart';
// import 'package:cinq_etoils/shared/CustomColors.dart';
// import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class ProjectScreen extends StatefulWidget {
//   FirebaseServiceProject firebaseServiceProject = FirebaseServiceProject();
//
//
//
//   @override
//   State<ProjectScreen> createState() => _ProjectScreenState();
// }
//
// class _ProjectScreenState extends State<ProjectScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//      widget.firebaseServiceProject.getProjects().then((value){
//        print(value.isEmpty);
//      });
//
//
//   }
//   var projectName = TextEditingController(),
//       projetUrl = TextEditingController(),phoneNumber = TextEditingController(),emailProfessionel = TextEditingController();
//   var formKey = GlobalKey<FormState>();
//   var _searchController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context)  {
//     return Scaffold(
//       body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           padding: const EdgeInsets.only(top:5),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10.0
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children:
//               [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children:
//                   [
//                     Flexible(
//                       child: AnimationSearchBar(
//                         searchBarWidth: MediaQuery.of(context).size.width - 85,
//                         isBackButtonVisible: false,
//                         centerTitle: "List Des Projets : ",
//                         centerTitleStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
//                         hintText: "Chercher Ici...",
//                         onChanged: (String) {
//                         },
//                         searchTextEditingController: _searchController,
//                       ),
//                     ),
//                     CustomWidgets.customIconButton(
//                       color: CustomColors.green,
//                         func: (){
//                             addProject();
//                         },
//                         icon:const Icon(
//                             Icons.add_business_rounded
//                         )
//                     )
//                   ],
//                 ),
//                 CustomWidgets.customDivider(),
//                 FutureBuilder(
//                     future: widget.firebaseServiceProject.getProjects(),
//                     builder: (context,dataSnapshot){
//                       if(dataSnapshot.connectionState == ConnectionState.waiting){
//                         return const Center(
//                           child : CircularProgressIndicator()
//                         );
//                       }else if(dataSnapshot.hasData && dataSnapshot.data!.isNotEmpty){
//                         Map<String,dynamic> mapData = dataSnapshot.data!.first;
//                         return ListView.separated(
//                               shrinkWrap: true,
//                               itemBuilder: (context,index) => CustomWidgets.customCard(mapData),
//                               separatorBuilder: (context,index) => CustomWidgets.verticalSpace(7.0),
//                               itemCount: dataSnapshot.data!.length
//                           );
//                       }else{
//                         return const Center(
//                           child: Text(
//                               "No Project Found",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold
//                               ),
//                           ),
//                         );
//                       }
//                     }
//                 )
//               ],
//             ),
//           ),
//       ),
//     );
//   }
//
//   void addProject(){
//     CustomWidgets.showAlertDialog(
//         context,
//         Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children:
//               [
//                 CustomWidgets.customTextFormField(
//                     funcValid: (value){
//                       if(value!.isEmpty) return "Enter le Nom de projet";
//                       return null;
//                     },
//                     prefixIcon: Icons.work,
//                     editingController: projectName,
//                     hintText: "Nom de Projet"
//                 ),
//                 CustomWidgets.verticalSpace(10.0),
//                 CustomWidgets.customTextFormField(
//                     funcValid: (value){
//                       if(value!.isEmpty) return "Enter Email";
//                       return null;
//                     },
//                     prefixIcon: Icons.email,
//                     editingController: emailProfessionel,
//                     hintText: "Email"
//                 ),
//                 CustomWidgets.verticalSpace(10.0),
//                 CustomWidgets.customTextFormField(
//                     funcValid: (value){
//                         return null;
//                     },
//                     prefixIcon: Icons.phone,
//                     editingController: phoneNumber,
//                     hintText: "Tele Projet"
//                 ),
//                 CustomWidgets.verticalSpace(10.0),
//                 CustomWidgets.customTextFormField(
//                     funcValid: (value){
//                       return null;
//                     },
//                     prefixIcon: Icons.link_outlined,
//                     editingController: projetUrl,
//                     hintText: "Projet URL"
//                 ),
//               ],
//             ),
//           ),
//         ),
//         [
//           CustomWidgets.customButton(
//               text: "Ajouter",
//               func: (){
//                 if(formKey.currentState!.validate()){
//                   widget.firebaseServiceProject.addProject(
//                     Projet(
//                         emailProfessionel: emailProfessionel.text,
//                         nomProjet: projectName.text,
//                         phoneNumber: phoneNumber.text,
//                         projetUrl: projetUrl.text ?? "",
//                     )
//                   ).then((value){
//                     Navigator.of(context).pop();
//                     CustomWidgets.showSnackBar(
//                         context,
//                         value,
//                         CustomColors.green);
//                     setState(() {
//
//                     });
//                   }).catchError((e){
//                     CustomWidgets.showSnackBar(
//                         context,
//                         e.toString(),
//                         CustomColors.red);
//                     print(e.toString());
//                   });
//                 }
//
//               },
//               color: CustomColors.green
//           ),
//           CustomWidgets.customButton(
//               text: "Annuler",
//               func: (){
//                 Navigator.of(context).pop();
//               },
//               color: CustomColors.red
//           ),
//         ]
//     );
//   }
// }
import 'package:cinq_etoils/model/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/model/project_model.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class ProjectScreen extends StatefulWidget {
  FirebaseServiceProject firebaseServiceProject = FirebaseServiceProject();
  AdminUser? adminUser;
  ProjectScreen({this.adminUser});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  var projectName = TextEditingController(),
      projetUrl = TextEditingController(),
      phoneNumber = TextEditingController(),
      emailProfessionel = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var formKeyBottomSheet = GlobalKey<FormState>();
  var _searchController = TextEditingController();
  String project_id = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: CustomColors.lightGrey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: AnimationSearchBar(
                        searchBarWidth: MediaQuery
                            .of(context)
                            .size
                            .width - 85,
                        isBackButtonVisible: false,
                        centerTitle: "List Des Projets : ",
                        centerTitleStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                        hintText: "Chercher Ici...",
                        onChanged: (value) {
                          setState(() {
                            _searchController.text = value;
                          });
                        },
                        searchTextEditingController: _searchController,
                      ),
                    ),
                    CustomWidgets.customIconButton(
                        color: CustomColors.green,
                        func: () {
                          addProject();
                        },
                        icon: const Icon(Icons.add_business_rounded)),
                  ],
                ),
                CustomWidgets.customDivider(),
                Expanded(
                  child: FutureBuilder(
                      future: searchProjects(_searchController.text),
                      builder: (context, dataSnapshot) {
                        if (dataSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (dataSnapshot.hasData &&
                            dataSnapshot.data!.isNotEmpty) {
                          List<Map<String, dynamic>> searchResults =
                          dataSnapshot.data as List<Map<String, dynamic>>;
                          return ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
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
                                              searchResults[index]["nomProjet"],
                                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),
                                            ),
                                            subtitle:Text("Email: ${searchResults[index]["email_professionel"]}\n"
                                                "Tel: ${searchResults[index]["phoneNumber"]}"
                                                "${searchResults[index]["projetUrl"] != "" ?  "\nURL : ${searchResults[index]["projetUrl"]}" : ""}"),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children:
                                              [
                                                const VerticalDivider(),
                                                CustomWidgets.customIconButton(
                                                  func: (){
                                                    projectName.text = searchResults[index]["nomProjet"].toString();
                                                    emailProfessionel.text = searchResults[index]["email_professionel"].toString();
                                                    phoneNumber.text = searchResults[index]["phoneNumber"].toString();
                                                    projetUrl.text = searchResults[index]["projetUrl"].toString() ?? "";
                                                    BottomSheet(searchResults[index]["id"]);
                                                  },
                                                  icon:Icon(
                                                    Icons.edit,
                                                    color: CustomColors.green,
                                                  ),
                                                ),
                                                CustomWidgets.customIconButton(
                                                  func: (){
                                                    deleteProject(searchResults[index]["id"]);
                                                    setState(() {
                                                      searchProjects(_searchController.text);
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
                              separatorBuilder: (context, index) => CustomWidgets.verticalSpace(7.0),
                              itemCount: searchResults.length);
                        } else if(dataSnapshot.connectionState == ConnectionState.none)
                        {
                            return const Center(
                              child: Column(
                                children:
                                [
                                  Icon(Icons.warning_outlined),
                                  Text(
                                    "Check Your Connection",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            );
                        }else {
                          return const Center(
                            child: Text(
                              "No Project Found",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                      }),
                )
              ],
            ),
          ),
        )
    );
  }
  Future<List<Map<String, dynamic>>> searchProjects(String query) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("projects")
          .where("nomProjet", isGreaterThanOrEqualTo: query)
          .where("nomProjet", isLessThan: query + 'z')
          .get();
      return querySnapshot.docs.map((e) {
        return {
          "id": e.id,
          "nomProjet": e["nomProjet"],
          "email_professionel": e["email_professionel"],
          "phoneNumber": e["phoneNumber"],
          "projetUrl": e["projetUrl"],
        };
      }).toList();
    } catch (e) {
      print("Error ${e.toString()}");
      return [];
    }
  }
  void addProject() {
    CustomWidgets.showAlertDialog(
        context,
        'Ajouter un projet',
         children : Form(
           key: formKey,
           child: SingleChildScrollView(
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 CustomWidgets.customTextFormField(
                     funcValid: (value) {
                       if (value!.isEmpty) return "Enter le Nom de projet";
                       return null;
                     },
                     icon: Icons.work,
                     borderColor: CustomColors.grey,
                     iconColor: CustomColors.grey,
                     colorText: CustomColors.grey,
                     editingController: projectName,
                     hintText: "Nom de Projet"),
                 CustomWidgets.verticalSpace(10.0),
                 CustomWidgets.customTextFormField(
                    inputType: TextInputType.emailAddress,
                     funcValid: (value) {
                       if (value!.isEmpty) return "Enter Email";
                       return null;
                     },
                     icon: Icons.email,
                     borderColor: CustomColors.grey,
                     iconColor: CustomColors.grey,
                     colorText: CustomColors.grey,
                     editingController: emailProfessionel,
                     hintText: "Email"),
                 CustomWidgets.verticalSpace(10.0),
                 CustomWidgets.customTextFormField(
                     inputType: TextInputType.number,
                     funcValid: (value) {
                       return null;
                     },
                     icon: Icons.phone,
                     borderColor: CustomColors.grey,
                     iconColor: CustomColors.grey,
                     colorText: CustomColors.grey,
                     editingController: phoneNumber,
                     hintText: "Tele Projet"),
                 CustomWidgets.verticalSpace(10.0),
                 CustomWidgets.customTextFormField(
                     inputType: TextInputType.url,
                     funcValid: (value) {
                       return null;
                     },
                     icon: Icons.link_outlined,
                     borderColor: CustomColors.grey,
                     iconColor: CustomColors.grey,
                     colorText: CustomColors.grey,
                     editingController: projetUrl,
                     hintText: "URL(optionel)"),
               ],
             ),
           ),
         ),
        list :  [
      CustomWidgets.customButton(
          text: "Ajouter",
          func: () {
            if (formKey.currentState!.validate()) {
              widget.firebaseServiceProject
                  .addProject(Projet(
                emailProfessionel: emailProfessionel.text,
                nomProjet: projectName.text,
                phoneNumber: phoneNumber.text,
                projetUrl: projetUrl.text ?? "",
              )).then((value) {
                Navigator.of(context).pop();
                CustomWidgets.showSnackBar(context, value, CustomColors.green);
                setState(() {});
                clearTextFields([projectName,projetUrl,phoneNumber,emailProfessionel]);
              }).catchError((e) {
                CustomWidgets.showSnackBar(context, e.toString(), CustomColors.red);
                print(e.toString());
              });

            }
          },
          color: CustomColors.green),
      CustomWidgets.customButton(
          text: "Annuler",
          func: () {
            Navigator.of(context).pop();
            clearTextFields([projectName,projetUrl,phoneNumber,emailProfessionel]);
          },
          color: CustomColors.red),
    ],
    );
  }
  deleteProject(String project_id){
    CustomWidgets.showAlertDialog(context,
        "Voulez-vous vraiment supprimer cette projet?",
        list: [
          CustomWidgets.customButton(color: CustomColors.red,text: "Oui", func: (){
            widget.firebaseServiceProject.deleteProject(project_id)
                .then((value){
                  CustomWidgets.showSnackBar(context,"Suppression success", CustomColors.green);
                  setState(() {
                    searchProjects(_searchController.text);
                    Navigator.pop(context);

                  });

            }).catchError((onError) => print("Error : ${onError.toString()}"));
          }),
          CustomWidgets.customButton(text: "Non", func: () {
            CustomWidgets.showSnackBar(context,"Operation annuler", CustomColors.grey);
            Navigator.pop(context);
          }),
        ]
    );
  }
  void BottomSheet(String project_id){
      var formKey = GlobalKey<FormState>();
      showBottomSheet(
          context: context,
          builder: (context){
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                        [
                          IconButton(
                              onPressed: () {
                                clearTextFields([projectName,projetUrl,phoneNumber,emailProfessionel]);
                                Navigator.pop(context);
                              },
                              icon:const Icon(Icons.arrow_back_ios)),
                          CustomWidgets.horizontalSpace(5),
                          const Text(
                                "Modifier Projet",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30.0,
                                ),
                          ),
                        ],
                      ),
                      CustomWidgets.verticalSpace(20.0),
                      CustomWidgets.customTextFormField(
                          icon: Icons.work,
                          funcValid: (value){
                            if(value!.isEmpty) return "Entre le nom de projet";
                            return null;
                          },
                          editingController: projectName,
                          hintText: "Nom de Projet",

                      ),
                      CustomWidgets.verticalSpace(20.0),
                      CustomWidgets.customTextFormField(
                        icon: Icons.work,

                        inputType: TextInputType.emailAddress,
                          funcValid: (value){
                            if(value!.isEmpty) return "Entre le Email de projet";
                            return null;
                          },
                          editingController: emailProfessionel,
                          hintText: "Email de Projet",
                      ),
                      CustomWidgets.verticalSpace(20.0),
                      CustomWidgets.customTextFormField(
                        icon: Icons.call,

                        inputType: TextInputType.number,
                          funcValid: (value){
                            if(value!.isEmpty) return "N° de Telephone de projet";
                            return null;
                          },
                          editingController: phoneNumber,
                          hintText: "N° Telephone de Projet",
                      ),
                      CustomWidgets.verticalSpace(20.0),
                      CustomWidgets.customTextFormField(
                        icon: Icons.link,

                        inputType: TextInputType.url,
                        funcValid: (value){
                          return null;
                        },
                        editingController: projetUrl,
                        hintText: "URL de Projet (optional)",
                      ),
                      CustomWidgets.verticalSpace(20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                        [
                          Flexible(
                              child: CustomWidgets.customButton(
                                  text: "Modifier",
                                  func: (){
                                    if(formKey.currentState!.validate()){
                                      Projet project = Projet(
                                          emailProfessionel: emailProfessionel.text,
                                          nomProjet: projectName.text,
                                          phoneNumber: phoneNumber.text,
                                          projetUrl: projetUrl.text ?? "",
                                      );
                                      widget.firebaseServiceProject.updateProject(project_id, project)
                                      .then((value){
                                        print("Projet Updated Success");
                                        setState(() {
                                          searchProjects(_searchController.text);
                                        });
                                        clearTextFields([projectName,projetUrl,phoneNumber,emailProfessionel]);
                                        Navigator.pop(context);
                                      }).catchError((e){
                                        print("Error : ${e.toString()}");
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
                                clearTextFields([projectName,projetUrl,phoneNumber,emailProfessionel]);
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

}
  clearTextFields(List<TextEditingController> list){
    for(int i = 0; i < list.length; i++){
      list[i].clear();
    }
}

