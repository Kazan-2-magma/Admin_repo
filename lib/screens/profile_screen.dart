import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.blue,
        leading: const Icon(Icons.menu),
        title:const Text("Cinq Etoils Admin"),
      ),
      body: Container(
        color: CustomColors.lightGrey,
        padding: EdgeInsets.symmetric(horizontal: 7.0, vertical:20),
        child: Column(
          children:
          [
            Container(
              decoration: BoxDecoration(
                color: CustomColors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.grey,
                    spreadRadius: 0,
                    offset: Offset(1.5, 1.5), // changes position of shadow
                  ),
                ],
              ),
              height: 490,
              child: Column(
                children:
                [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Row(
                          children: [
                            CircleAvatar(
                              //IMAGE
                              radius: 50,
                            ),
                            CustomWidgets.horizontalSpace(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Adolf Hitler",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.start,
                                  "id: 007",
                                  style: TextStyle(
                                    color: CustomColors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        CustomWidgets.customButton(
                            text: 'Edit photo',
                            func: () {  },
                            color: CustomColors.transparent,
                            shadowColor: CustomColors.transparent,
                            surfaceTintColor: CustomColors.transparent,
                            colorText: CustomColors.grey,
                            radius: 30,
                            borderColor: CustomColors.grey,
                            borderWidth: 1.2,

                        ),
                      ],
                    ),
                  ),




                  Divider(height: 1.0,indent: 45,),
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                      [
                        Row(
                          children: [
                            Icon(Icons.person,size: 30,color: CustomColors.grey,),
                            CustomWidgets.horizontalSpace(10),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nom",style: TextStyle(color: CustomColors.grey),),
                                Text(
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                  "Adolf Hitler"//Nom Data
                                ),
                              ],
                            ),
                          ],
                        ),
                        CustomWidgets.customIconButton(
                            func: () {  },
                            icon: Icon(Icons.edit,color: CustomColors.grey,),
                        )
                      ],
                    ),
                  ),

                  Divider(height: 1.0,indent: 45),
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
                    child: Row(
                      children:
                      [
                        Icon(Icons.call,size: 30,color: CustomColors.grey,),
                        CustomWidgets.horizontalSpace(10),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Telephone",style: TextStyle(color: CustomColors.grey),),
                            Text(
                              style: TextStyle(fontWeight: FontWeight.w600),
                              "+212 723-3298"//Nom Data
                            ),
                          ],
                        )

                      ],
                    ),
                  ),

                  Divider(height: 1.0,indent: 45,),
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
                    child: Row(
                      children:
                      [
                        Icon(Icons.email,size: 30,color: CustomColors.grey,),
                        CustomWidgets.horizontalSpace(10),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email",style: TextStyle(color: CustomColors.grey),),
                            Text(
                              style: TextStyle(fontWeight: FontWeight.w600),
                              "Adolf Hitler"//Nom Data
                            ),
                          ],
                        )

                      ],
                    ),
                  ),

                  Divider(height: 1.0,indent: 45,),
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(/*vertical: 15,*/ horizontal:5),
                    child: Row(
                      children:
                      [
                        Icon(Icons.person_pin_rounded,size: 30,color: CustomColors.grey,),
                        CustomWidgets.horizontalSpace(10),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Role",style: TextStyle(color: CustomColors.grey),),
                            Text(
                              style: TextStyle(fontWeight: FontWeight.w600),
                              "Hokage"//Nom Data
                            ),
                          ],
                        )

                      ],
                    ),
                  ),


                  CustomWidgets.verticalSpace(30.0),


                  //tomorrow ndir had button ان شاء الله################

                  CustomWidgets.customButton(
                      text: "Modifier mot de pass",
                      func: (){

                      },
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
