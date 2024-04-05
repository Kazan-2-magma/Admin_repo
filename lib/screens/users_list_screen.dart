
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //////////////////////////////// had l Map ghir test
    Map<String,dynamic> maptest = new Map<String,dynamic>();


    var _searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.blue,
        leading: const Icon(Icons.menu),
        title:const Text("Cinq Etoils Admin"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top:5),
        color: CustomColors.lightGrey,
        child: Padding(

          padding: const EdgeInsets.symmetric(
              horizontal: 10.0
          ),
          child: Column(
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
                      centerTitle: "List Des Utilisateurs : ",
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
                      },
                      icon:const Icon(
                          Icons.add_business_rounded
                      )
                  )
                ],
              ),
              CustomWidgets.customDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomWidgets.customCard(maptest,isUser: true),
                      CustomWidgets.customCard(maptest,isUser: true),
                      CustomWidgets.customCard(maptest,isUser: true),
                      CustomWidgets.customCard(maptest,isUser: true),
                      CustomWidgets.customCard(maptest,isUser: true),
                      CustomWidgets.customCard(maptest,isUser: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
