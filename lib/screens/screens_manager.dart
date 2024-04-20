import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/UserModel.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:cinq_etoils/screens/UsersScreen.dart';
import 'package:cinq_etoils/screens/profile_screen.dart';
import 'package:cinq_etoils/screens/project_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../shared/CustomColors.dart';
import '../shared/Widgets/CustomWidgets.dart';
import 'ClientsScreen.dart';
import 'home_screen.dart';

class ScreenManager extends StatefulWidget {
  AdminUser? userData;
  ScreenManager({this.userData});


  @override
  State<ScreenManager> createState() => _ScreenManagerState();

}

class _ScreenManagerState extends State<ScreenManager> {
  String title = "";
  Widget currentScreen = Container();
  final FirebaseServiceUser firebaseServiceuser=FirebaseServiceUser();


  @override
  void initState() {
    title = "Accueil";
    currentScreen = HomeScreen();
    super.initState();
  }

  final GlobalKey<SliderDrawerState> _sliderDrawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
          key: _sliderDrawerKey,
          appBar: SliderAppBar(
              appBarColor: CustomColors.blue,
              title: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 25,color: Colors.white)
              )
          ),
          slider: _SliderView(
            adminUser: widget.userData,
            onItemClick: (title,widget){
              _sliderDrawerKey.currentState!.closeSlider();
              setState(() {
                this.title= title;
                currentScreen = widget;
                isSelected: currentScreen == this.title;
              });
            },
          ),
          child: Container(
            child: currentScreen,
          ),
        )
    );
  }
}

class _SliderView extends StatefulWidget{

  AdminUser? adminUser;
  final Function(String,Widget)? onItemClick;
  _SliderView({Key? key,this.adminUser, this.onItemClick}) : super(key: key);
  FirebaseServiceUser _firebaseServiceUser = FirebaseServiceUser();

  @override
  State<_SliderView> createState() => _SliderViewState();

}

class _SliderViewState extends State<_SliderView> {
  late List<Menu> list;
  String? _imageStr;
  @override
  void initState() {
    super.initState();
    list =[
      Menu(Icons.home, 'Accueil',HomeScreen(adminUser: widget.adminUser),true),
      Menu(Icons.people_alt_rounded, 'Clients',ClientsScreen(adminUser :widget.adminUser),false),
      Menu(Icons.people, 'Utilisateurs',UsersScreen(adminUser :widget.adminUser),false),
      Menu(Icons.business_center, 'Projets',ProjectScreen(adminUser : widget.adminUser),false),
      Menu(Icons.person, 'Profile',ProfileScreen(adminUser: widget.adminUser),false),
      //Menu(Icons.arrow_back_ios, 'LogOut',Container())
    ];
    print("from Sliider View ${widget.adminUser!.email}");
  }



// Define a function to handle item selection
  void handleItemSelection(String title) {
    setState(() {
      // Update the isSelected property based on the selected title
      list.forEach((item) {
        item.isSelected = item.title == title;
      });
    });
  }


  ImageProvider? convertStringToXFile(String imageString)  {
    try {
      Uint8List bytes = base64Decode(imageString);
      return MemoryImage(bytes);
    }catch (e) {
      print('Error converting string to XFile: $e');
      return null;
    }
  }




  @override
  Widget build(BuildContext context) {
    return  Container(
      color: CustomColors.lightGrey,
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              CircleAvatar(
                radius: 42,
                backgroundColor: CustomColors.blue,
                child: widget.adminUser!.photoUrl.isNotEmpty
                    ? CircleAvatar(
                  radius: 60,
                  backgroundImage : convertStringToXFile(widget.adminUser!.photoUrl),
                )
                    : ProfilePicture(
                  //IMAGE
                  radius: 50,
                  name: widget.adminUser!.getFullname(),
                  fontsize: 21,
                  img: _imageStr,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  widget.adminUser!.getFullname(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(color: CustomColors.grey),

          ...list.map((e){
            return _SliderMenuItem(
              title: e.title,
              currentScreen: e.widget,
              iconData: e.iconData,
              isSelected: e.isSelected,
              onItemClick: widget.onItemClick,
              handleItemSelection: handleItemSelection, // Pass handleItemSelection

            );
          }),

          Divider(indent: 20,endIndent: 20,color: CustomColors.grey),

          CustomWidgets.customButtonWithIcon(

              radius: 0,
              color: CustomColors.red,
              text: "Logout",
              func: (){
                widget._firebaseServiceUser.signOut();
              },
              icon: Icons.logout
          )
        ],
      ),
    );;
  }
}



class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Widget currentScreen;
  final bool isSelected;
  final Function(String, Widget)? onItemClick;
  final void Function(String) handleItemSelection; // Add handleItemSelection


  const _SliderMenuItem(
      {Key? key,
        required this.title,
        required this.currentScreen,
        required this.iconData,
        required this.isSelected,
        required this.onItemClick,
        required this.handleItemSelection, // Accept handleItemSelection

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? Color.fromRGBO(0, 176, 255, 0.3) : Colors.grey[200],
      child: ListTile(
          title: Text(title,
              style: TextStyle(
                  color: isSelected ? CustomColors.blue : CustomColors.black,
                  fontFamily: 'BalsamiqSans_Regular')),
          leading: Icon(iconData, color: isSelected ? CustomColors.blue : CustomColors.black),
          onTap: () {
            // Call handleItemSelection to update isSelected
            handleItemSelection(title);
            // Call onItemClick to notify the parent widget
            onItemClick?.call(title, currentScreen);
          }), // Call onItemClick
    );
  }
}
class Menu {
  final IconData iconData;
  final String title;
  final Widget widget;
  bool isSelected;


  Menu(this.iconData, this.title,this.widget,this.isSelected);
}