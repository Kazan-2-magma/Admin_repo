import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/project_model.dart';
import '../shared/CustomColors.dart';

class HomeScreen extends StatefulWidget {
  AdminUser? adminUser;
  HomeScreen({this.adminUser});
  FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();
  FirebaseServiceProject _firebaseServiceProject = FirebaseServiceProject();


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String,dynamic>> listOfProjects =[];

  @override
  void initState() {
    super.initState();
    fetchDataSize();

  }

  void fetchDataSize()async {
    var data = await widget._firebaseServiceProject.getProjects();
   setState(() {
     listOfProjects = data;
   });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      color: CustomColors.lightGrey,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 10,
                child: Card(
                  shadowColor: Colors.black,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: CustomColors.red,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, -1),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20,top: 15),
                              child: Icon(
                                Icons.people_alt_rounded,
                                size: 50,
                                color: CustomColors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, -1),
                            child: Padding(
                              padding:const EdgeInsets.only(left: 5,top: 15),
                              child: Text(
                                'Clients',
                                style: TextStyle(fontSize: 40, color: CustomColors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment:const AlignmentDirectional(1, 1),
                              child: Padding(
                                padding:const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Nombre : +999',
                                  style: TextStyle(fontSize: 20, color: Colors.grey[350]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width, // Largeur souhaitée de la Card
                height: 150, // Hauteur souhaitée de la Card
                child: Card(
                  shadowColor: Colors.black,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: CustomColors.blue,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, -1),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20,top: 15),
                              child: Icon(
                                Icons.people,
                                size: 50,
                                color: CustomColors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5,top: 15),
                              child: Text(
                                'Utilisateurs',
                                style: TextStyle(fontSize: 40, color: CustomColors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1, 1),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Nombre : +999',
                                  style: TextStyle(fontSize: 20, color: Colors.grey[350]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Card(
                  shadowColor: Colors.black,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: CustomColors.green,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1, -1),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20,top: 15),
                              child: Icon(
                                Icons.work,
                                size: 50,
                                color: CustomColors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5,top: 15),
                              child: Text(
                                'Projets',
                                style: TextStyle(fontSize: 40, color: CustomColors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1, 1),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Nombre : ${listOfProjects.length}',
                                  style: TextStyle(fontSize: 20, color: Colors.grey[350]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    )

    );
  }
}
