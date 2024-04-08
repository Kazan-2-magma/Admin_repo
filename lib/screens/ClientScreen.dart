
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/UserModel.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClientScreen extends StatefulWidget {
  FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();
  FirebaseServiceProject _firebaseServiceProject = FirebaseServiceProject();
  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  Widget build(BuildContext context){
    TextEditingController _searchController = TextEditingController();
    // Map<String,dynamic> projectItems = widget._firebaseServiceProject.getProjects();

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
                  ),
                  const Divider(),
                  StreamBuilder(
                      stream: widget._firebaseServiceUser.getUsers(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(snapshot.hasData){
                          return Expanded(
                            child : ListView.separated(
                              itemCount: snapshot.data!.length,
                              separatorBuilder: (context,index) => CustomWidgets.verticalSpace(10.0),
                              itemBuilder: (conetxt,index){
                                UserModel user = snapshot.data![index];
                                return CustomWidgets.customCard(isUser:true,user: user);
                              },
                            )
                          );
                        }else{
                          return const Center(
                            child: Text(
                              "No Clients found",
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
          )
        ),
    );
  }
}
