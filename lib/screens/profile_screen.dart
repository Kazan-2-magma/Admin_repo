import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children:
          [
            Card(
              child: Text(
                  "PROFILE",
                  style: TextStyle(
                    color: CustomColors.blue,
                  ),
              ),
            ),
            CustomWidgets.verticalSpace(10.0),
            Card(
              child: Column(
                children:
                [
                  Row(
                    children:
                    [
                      CircleAvatar(
                        //IMAGE
                      ),
                      ElevatedButton(
                          onPressed: (){

                          },
                          child: Text("Ajouter")
                      ),
                    ],
                  ),
                  Divider(height: 1.0,),
                  Row(
                    children:
                    [
                      Icon(Icons.person),
                      Text("NOM"),
                      Text(
                        ""//Nom Data
                      )

                    ],
                  ),
                  Row(
                    children:
                    [
                      Icon(Icons.person),
                      Text("PRENOM"),
                      Text(
                          ""//Nom Data
                      )

                    ],
                  ),
                  Row(
                    children:
                    [
                      Icon(Icons.person),
                      Text("TELEPHONE"),
                      Text(
                          ""//Nom Data
                      )

                    ],
                  ),
                  Row(
                    children:
                    [
                      Icon(Icons.person),
                      Text("ADRESSE EMAIL"),
                      Text(
                          ""//Nom Data
                      )

                    ],
                  ),
                  Row(
                    children:
                    [
                      Icon(Icons.person),
                      Text("ROLE"),
                      Text(
                          ""//Nom Data
                      )

                    ],
                  ),
                  CustomWidgets.verticalSpace(30.0),
                  CustomWidgets.customButton(
                      text: "Modifier mot de pass",
                      func: (){

                      },
                      color: CustomColors.green
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
