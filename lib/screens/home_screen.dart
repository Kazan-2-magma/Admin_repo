import 'package:cinq_etoils/firebase_services/FirebaseServiceClients.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/UserModel.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:cinq_etoils/screens/ClientsScreen.dart';
import 'package:cinq_etoils/screens/screens_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/Client.dart';
import '../model/project_model.dart';
import '../shared/CustomColors.dart';

class HomeScreen extends StatefulWidget {
  AdminUser? adminUser;
  HomeScreen({this.adminUser});
  FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();
  FirebaseServiceClients _firebaseServiceClients = FirebaseServiceClients();
  FirebaseServiceProject _firebaseServiceProject = FirebaseServiceProject();


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String,dynamic>> listOfProjects =[];
  List<Client>? listOfClients =[];
  List<UserModel> listOfUsers =[];

  @override
  void initState() {
    super.initState();
    fetchDataSize();

  }

  void fetchDataSize()async {
    var data = await widget._firebaseServiceProject.getProjects();
    var clientData = await widget._firebaseServiceClients.getClients();
    var usersData = await widget._firebaseServiceUser.getUsers();
   setState(() {
     listOfProjects = data;
     listOfClients = clientData;
     listOfUsers = usersData;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        color: CustomColors.lightGrey,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children:
            [
              GestureDetector(
                onTap: (){
                  setState(() {
                    ScreenManager.setCurrentScreen(ClientsScreen(adminUser: widget.adminUser,));
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
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
                          children:
                          [
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
                                      'Nombre : ${listOfClients!.length}',
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
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 150,
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
                                    'Nombre : ${listOfUsers.length}',
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
              Container(
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
            ],
            )
            )
            ),
      ),
    );
  }
}
