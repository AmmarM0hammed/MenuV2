import 'package:flutter/material.dart';

import '../function/theme.dart';
import '../model/CategoryModels.dart';
import "../screen/HomeScreen.dart" as home;
import '../screen/HomeScreen.dart';

class Category extends StatefulWidget {
  int? _selectIndex;
  VoidCallback? update;
  Category({Key? key, required this.update}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int _selectIndex = home.selectIndex;
  CategoryView _categoryView = new CategoryView();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FutureBuilder(
        future: _categoryView.getData(),
        builder: (context, AsyncSnapshot<List<Map>> snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              color: JK_Primery,
            ));
          else
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: (snapshot.hasData) ? snapshot.data!.length : 0,
              itemBuilder: (context, index) {
                return Center(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      
                      setState(() {
                        _selectIndex = index;
                        home.selectIndex = index;
                        print(home.selectIndex);
                      });
                      widget.update!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data![index]['name'],
                            style: TextStyle(
                                fontSize: 20,
                                color: (_selectIndex == index)
                                    ? JK_Primery
                                    : JK_Gray),
                          ),
                          SizedBox(height: 5),
                          if (_selectIndex == index)
                            Container(
                              width: 50,
                              height: 3,
                              color: JK_Primery,
                            )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}
