
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceProject.dart';
import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/UserModel.dart';
import '../model/Users.dart';

class ClientScreen extends StatefulWidget {
  FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();
  FirebaseServiceProject _firebaseServiceProject = FirebaseServiceProject();
  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  Widget build(BuildContext context){
    TextEditingController _searchController = TextEditingController() ;//////////////////////////////// had l Map ghir test
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
                      Flexible(
                        child: AnimationSearchBar(
                          searchBarWidth: MediaQuery.of(context).size.width - 70,
                          isBackButtonVisible: false,
                          centerTitle: "List Des Clients : ",
                          centerTitleStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                          hintText: "Chercher un client...",
                          onChanged: (String) {
                          },
                          searchTextEditingController: _searchController,
                        ),
                      ),
                      CustomWidgets.customIconButton(
                        color: CustomColors.green,
                        func: (){
                        },
                        icon:const Icon(Icons.search),

                      ),
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
                          items: [],
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
                        }else if(snapshot.hasData ){
                          List<UserModel> filteredUsers = snapshot.data!.where((user) =>
                          user.firstName.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                              user.lastName.toLowerCase().contains(_searchController.text.toLowerCase())
                          ).toList();
                          return Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context,index) => CustomWidgets.verticalSpace(10.0),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context,index){
                                  AdminUser user =  snapshot.data![index] as AdminUser;
                                  return CustomWidgets.customCardUser(user);
                                },
                              )
                          );
                        }else{
                          return const Center(
                            child: Text(
                              "No Clients Found",
                              style:TextStyle(
                                  fontSize: 30.0,
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
