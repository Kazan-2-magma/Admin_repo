
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProjectScreen extends StatefulWidget {
  FirebaseServiceProject firebaseServiceProject = FirebaseServiceProject();



  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {

  @override
  void initState() {
    super.initState();
  }
  var projectName = TextEditingController(),projectDescription = TextEditingController(),
      projetUrl = TextEditingController();


  @override
  Widget build(BuildContext context)  {
    var _searchController = TextEditingController();
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top:5),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children:
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Flexible(
                    child: AnimationSearchBar(
                      searchBarWidth: MediaQuery.of(context).size.width - 85,
                      isBackButtonVisible: false,
                      centerTitle: "List Des Projets : ",
                      centerTitleStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                      hintText: "Chercher Ici...",
                      onChanged: (String) {
                      },
                      searchTextEditingController: _searchController,
                    ),
                  ),
                  CustomWidgets.customIconButton(
                    color: CustomColors.green,
                      func: (){
                          addProject();
                      },
                      icon:const Icon(
                          Icons.add_business_rounded
                      )
                  )
                ],
              ),
              CustomWidgets.customDivider(),
              FutureBuilder(
                  future: widget.firebaseServiceProject.getProjects(),
                  builder: (context,dataSnapshot){
                    if(dataSnapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child : CircularProgressIndicator()
                      );
                    }else if(dataSnapshot.hasData && dataSnapshot.data!.isNotEmpty){
                      Map<String,dynamic> mapData = dataSnapshot.data!.first;
                      return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context,index) => CustomWidgets.customCard(mapData),
                            separatorBuilder: (context,index) => CustomWidgets.verticalSpace(7.0),
                            itemCount: dataSnapshot.data!.length
                        );
                    }else{
                      return const Center(
                        child: Text(
                            "No Project Found",
                            style: TextStyle(
                              color: Colors.black,
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
    );
  }

  void addProject(){
    CustomWidgets.showAlertDialog(
        context,
        Column(
          children:
          [
            CustomWidgets.customTextFormField(
                funcValid: (value){

                },
                editingController: projectName,
                hintText: "Nom de Projet"
            ),
          ],
        ),
        [
          CustomWidgets.customButton(
              text: "Ajouter",
              func: (){

              },
              color: CustomColors.green
          )
        ]
    );
  }
}
