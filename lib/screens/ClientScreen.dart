
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController() ;//////////////////////////////// had l Map ghir test
    Map<String,dynamic> maptest = new Map<String,dynamic>();

    var dropMenuValue;
    TextEditingController dropDownSearchBarController = TextEditingController();

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

                      Row(
                        children:
                        [
                          /*DropdownButton(
                            hint: const Text("Choisir un projet"),
                            value: dropMenuValue,
                            items: items.map((e){
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(e)
                              );
                            }).toList(),
                            onChanged: (value){
                              setState(() {
                                dropMenuValue = value.toString();
                              });
                            },
                          ),*/

                          //////new dropDownMenu with a new fuc*ing searchBar wooooooow

                        AnimationSearchBar(
                          searchBarWidth: MediaQuery.of(context).size.width - 70,
                          isBackButtonVisible: false,
                          centerTitle: "List Des Clients : ",
                          centerTitleStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                          hintText: "Chercher un client...",
                          onChanged: (String) {
                          },
                          searchTextEditingController: _searchController,
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
                      )
                    ],
                  ),
                  CustomWidgets.customDivider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomWidgets.customCard(maptest,checkbox: true),
                          CustomWidgets.customCard(maptest,checkbox: true),
                          CustomWidgets.customCard(maptest,checkbox: true),
                          CustomWidgets.customCard(maptest,checkbox: true),
                          CustomWidgets.customCard(maptest,checkbox: true),
                          CustomWidgets.customCard(maptest,checkbox: true),
                          CustomWidgets.customCard(maptest,checkbox: true),
                          CustomWidgets.customCard(maptest,checkbox: true),
                        ],
                      ),
                    ),
                  ),
                ],
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
        ),
      ),
    );
  }
}
