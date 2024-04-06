
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
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

    //////////////////////////////// had l Map ghir test
    Map<String,dynamic> maptest = new Map<String,dynamic>();
    var items = [
      "project 1",
      "project 0.5",
      "project 2",
    ];
    var dropMenuValue;

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
