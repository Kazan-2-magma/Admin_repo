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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/model/project_model.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';

class ProjectScreen extends StatefulWidget {
  FirebaseServiceProject firebaseServiceProject = FirebaseServiceProject();

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  var projectName = TextEditingController(),
      projetUrl = TextEditingController(),
      phoneNumber = TextEditingController(),
      emailProfessionel = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.firebaseServiceProject.getProjects().then((value) {
      print(value.isEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
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
                        onChanged: (String) {},
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
                FutureBuilder(
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
                            itemBuilder: (context, index) =>
                                CustomWidgets.customCard(searchResults[index]),
                            separatorBuilder: (context, index) =>
                                CustomWidgets.verticalSpace(7.0),
                            itemCount: searchResults.length);
                      } else {
                        return const Center(
                          child: Text(
                            "No Project Found",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                    })
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
          "emailProfessionel": e["email_professionel"],
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
        Form(
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
                    prefixIcon: Icons.work,
                    editingController: projectName,
                    hintText: "Nom de Projet"),
                CustomWidgets.verticalSpace(10.0),
                CustomWidgets.customTextFormField(
                    funcValid: (value) {
                      if (value!.isEmpty) return "Enter Email";
                      return null;
                    },
                    prefixIcon: Icons.email,
                    editingController: emailProfessionel,
                    hintText: "Email"),
                CustomWidgets.verticalSpace(10.0),
                CustomWidgets.customTextFormField(
                    funcValid: (value) {
                      return null;
                    },
                    prefixIcon: Icons.phone,
                    editingController: phoneNumber,
                    hintText: "Tele Projet"),
                CustomWidgets.verticalSpace(10.0),
                CustomWidgets.customTextFormField(
                    funcValid: (value) {
                      return null;
                    },
                    prefixIcon: Icons.link_outlined,
                    editingController: projetUrl,
                    hintText: "Projet URL"),
              ],
            ),
          ),
        ), [
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
              ))
                  .then((value) {
                Navigator.of(context).pop();
                CustomWidgets.showSnackBar(context, value, CustomColors.green);
                setState(() {});
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
          },
          color: CustomColors.red),
    ]);
  }
}


