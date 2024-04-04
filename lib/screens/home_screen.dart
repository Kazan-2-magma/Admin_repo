import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
  GlobalKey<SliderDrawerState>();
  late String title;

  @override
  void initState() {
    title = "Home";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
          appBar: SliderAppBar(
            appBarColor: Colors.white,
            title: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ),
          key: _sliderDrawerKey,
          sliderOpenSize: 179,
          slider: _SliderView(
            onItemClick: (title) {
              _sliderDrawerKey.currentState!.closeSlider();
              setState(() {
                this.title = title;
              });
            },
          ),
          child: _AuthorList(),
        ),
    );
  }
}

class _SliderView extends StatefulWidget {
  final Function(String)? onItemClick;

  const _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  _SliderViewState createState() => _SliderViewState();
}

class _SliderViewState extends State<_SliderView> {
  String selectedItem = 'Home';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 30),
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
          const SizedBox(height: 20),
          const Text(
            'Nick',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 20),
          ...[
            Menu(Icons.home, 'Home'),
            Menu(Icons.business_center, 'Projet'),
            Menu(Icons.people, 'Client'),
            Menu(Icons.group, 'Utilisateurs'),
            Menu(Icons.arrow_back_ios, 'LogOut')
          ].map((menu) {
            return _SliderMenuItem(
              title: menu.title,
              iconData: menu.iconData,
              onTap: () {
                setState(() {
                  selectedItem = menu.title;
                });
                widget.onItemClick?.call(menu.title);
              },
              isSelected: selectedItem == menu.title,
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? onTap;
  final bool isSelected;

  const _SliderMenuItem({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? CustomColors.blue : Colors.black,
          fontFamily: 'BalsamiqSans_Regular',
        ),
      ),
      leading: Icon(iconData, color: isSelected ? CustomColors.blue : Colors.black),
      onTap: onTap,
    );
  }
}

class _AuthorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Quotes> quotesList = [];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemBuilder: (builder, index) {
          return LimitedBox(
            maxHeight: 150,
            child: Container(
              decoration: BoxDecoration(
                color: quotesList[index].color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      quotesList[index].author,
                      style: const TextStyle(
                        fontFamily: 'BalsamiqSans_Blod',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      quotesList[index].quote,
                      style: const TextStyle(
                        fontFamily: 'BalsamiqSans_Regular',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (builder, index) {
          return const Divider(
            height: 10,
            thickness: 0,
          );
        },
        itemCount: quotesList.length,
      ),
    );
  }
}

class Quotes {
  final MaterialColor color;
  final String author;
  final String quote;

  Quotes(this.color, this.author, this.quote);
}

class Menu {
  final IconData iconData;
  final String title;

  Menu(this.iconData, this.title);
}