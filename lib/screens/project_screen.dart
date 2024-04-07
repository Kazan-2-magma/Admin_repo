
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  var projectName = TextEditingController(),
      projectDescription = TextEditingController(),
      projetUrl = TextEditingController();

  var items = [
    "project 1",
    "spongbob 0.5",
    "maprojich *",
    "jetpak &",
    "project 2",
  ];

  Map<String,dynamic> mapData = {
    "project 1" : 43,
    "rdsss 1" : 43,
    "jihhaha 1" : 43,
    "bruburur 1" : 43,
  };


  TextEditingController dropDownSearchBarController = TextEditingController();
  String? dropMenuValue;

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.blue,
        leading: const Icon(Icons.menu),
        title:const Text("Cinq Etoils Admin"),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top:5),
          color: CustomColors.lightGrey,
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children:
              [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                      Text("Liste des Projets : ",
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),

                      Row(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Choisir un projet',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              value: dropMenuValue,
                              onChanged: (value) {
                                setState(() {
                                  dropMenuValue = value;
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
                                searchController: dropDownSearchBarController,
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
                                    controller: dropDownSearchBarController,
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
                                  dropDownSearchBarController.clear();
                                }
                              },
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
                          ),
                        ],
                      )

                    ],
                  ),
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
