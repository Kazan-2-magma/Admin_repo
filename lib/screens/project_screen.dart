
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:cinq_etoils/shared/CustomColors.dart';
import 'package:cinq_etoils/shared/Widgets/CustomWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.blue,
        leading: const Icon(Icons.menu),
        title:const Text("Cinq Etoils Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0
        ),
        child: Column(
          children:
          [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Flexible(
                  child: AnimationSearchBar(
                    searchBarWidth: MediaQuery.of(context).size.width - 85,
                    isBackButtonVisible: false,
                    centerTitle: "List Des Projects",
                    onChanged: (String) {
                    },
                    searchTextEditingController: _searchController,
                  ),
                ),
                CustomWidgets.CustomIconButton(
                  color: CustomColors.green,
                    func: (){
                    },
                    icon:const Icon(
                        Icons.add_box
                    )
                )
              ],
            ),
            CustomWidgets.verticalSpace(8.0),
            CustomWidgets.CustomDivider(),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                title: Text("project"),
                subtitle:Text("email \nPhone number"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [
                    CustomWidgets.CustomIconButton(
                        func: (){

                        },
                        icon:Icon(
                            Icons.edit,
                            color: CustomColors.green,
                        ),
                    ),
                    CustomWidgets.CustomIconButton(
                      func: (){

                      },
                      icon:Icon(
                          Icons.delete,
                          color: CustomColors.red,
                      ),
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
