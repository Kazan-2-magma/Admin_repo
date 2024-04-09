import 'package:cinq_etoils/firebase_services/FirebaseServiceUser.dart';
import 'package:cinq_etoils/model/UserModel.dart';
import 'package:cinq_etoils/model/Users.dart';
import 'package:cinq_etoils/screens/ClientScreen.dart';
import 'package:cinq_etoils/screens/profile_screen.dart';
import 'package:cinq_etoils/screens/project_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

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

  @override
  void initState() {
    title = "Home";
    currentScreen = HomeScreen();
    print("From screen manager ${widget.userData?.toJson()}");
    super.initState();
  }

  final GlobalKey<SliderDrawerState> _sliderDrawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
          key: _sliderDrawerKey,
          appBar: SliderAppBar(
              appBarColor: Colors.white,
              title: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700))),
          slider: _SliderView(
            adminUser: widget.userData,
            onItemClick: (title,widget){
              _sliderDrawerKey.currentState!.closeSlider();
              setState(() {
                this.title= title;
                currentScreen = widget;
              });
            },
          ),
          child: Container(
            child: currentScreen,
          ),
        ));
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
  @override
  void initState() {
    super.initState();
    list =[
      //Menu(Icons.home, 'Home',HomeScreen(adminUser: ScreenManager().userData)),
      // Menu(Icons.business_center_outlined, 'Projets',ProjectScreen(adminUser : ScreenManager().adminUser)),
      // Menu(Icons.people, 'Utilisateurs',ClientScreen(adminUser : ScreenManager().adminUser)),
      Menu(Icons.person, 'Profile',ProfileScreen(adminUser: widget.adminUser,)),
      //Menu(Icons.arrow_back_ios, 'LogOut',Container())
    ];
    print("from Sliider View ${widget.adminUser!.email}");
  }





  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: Image.network(
                  'https://nikhilvadoliya.github.io/assets/images/nikhil_1.webp')
                  .image,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Nick',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...list.map((e){
            return _SliderMenuItem(
                title: e.title,
                currentScreen: e.widget,
                iconData: e.iconData,
                onTap:widget.onItemClick
            );
          }),
          ElevatedButton(
              onPressed: (){
                widget._firebaseServiceUser.signOut();
              },
              child: Text("LogOut")
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
  final Function(String,Widget)? onTap;

  const _SliderMenuItem(
      {Key? key,
        required this.title,
        required this.currentScreen,
        required this.iconData,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
        leading: Icon(iconData, color: Colors.black),
        onTap: () => onTap?.call(title,currentScreen));
  }
}
class Menu {
  final IconData iconData;
  final String title;
  final Widget widget;

  Menu(this.iconData, this.title,this.widget);
}