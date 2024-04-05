
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //////////////////////////////// had l Map ghir test
    Map<String,dynamic> maptest = new Map<String,dynamic>();
    var items = [];
    var dropMenuValue = "";

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  const Text(
                      "List Des Client",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                      [
                        DropdownButton(
                            hint: const Text("Choisir un projet"),
                            items: items.map((e){
                              return const DropdownMenuItem(
                                  child: Text("Name")
                              );
                            }).toList(),
                            onChanged: (value){
                              dropMenuValue = value;
                            },
                        ),
                        CustomWidgets.CustomIconButton(
                            color: CustomColors.green,
                            func: (){
                            },
                            icon:const Icon(
                                Icons.add_business_rounded
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
              CustomWidgets.CustomDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomWidgets.CustomCard(maptest),
                      CustomWidgets.CustomCard(maptest),
                      CustomWidgets.CustomCard(maptest),
                      CustomWidgets.CustomCard(maptest),
                      CustomWidgets.CustomCard(maptest),
                      CustomWidgets.CustomCard(maptest),
                      CustomWidgets.CustomCard(maptest),
                      CustomWidgets.CustomCard(maptest),
                      CustomWidgets.CustomCard(maptest),
                      CustomWidgets.CustomCard(maptest),
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
