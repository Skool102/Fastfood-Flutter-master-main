

import 'package:flutter/material.dart';

import '../utils/CommonColors.dart';
import '../utils/constant.dart';
import '../utils/local_images.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> items = [
    'Hamburger Deluxe',
    'Southern Fried Chicken',
    'Butter Chicken',
    'Vindaloo',
    'Tomato soup',
    'Apple pie',
    'Creamed spinach',
    'Fried green tomatoes',
    'Cheese Sandwich',
    'Donut',
  ];

  List<String> filteredItems = [];

  void filterSearchResults(String query) {
    List<String> searchResults = [];

    if (query.isNotEmpty) {
      items.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(item);
        }
      });
    } else {
      searchResults = List.from(items);
    }

    setState(() {
      filteredItems = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 30),
          padding: const EdgeInsets.symmetric(horizontal: 15.0,),
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset(LocalImages.ic_back,width: 50.0,height: 50,fit: BoxFit.fitWidth,),
              ),
              Container(
                width: MediaQuery.of(context).size.width-140,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color:Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                      )
                    ]
                ),
                child: Row(
                  children: [
                    Image.asset(LocalImages.ic_search,width: 30.0,),
                    Flexible(
                      child: TextField(
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        decoration: InputDecoration(
                          hintText: AppConstants.search,
                          hintStyle: TextStyle(fontSize: 18,color:Colors.grey),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 18,color: CommonColors.primaryTextColor)
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0,),
              InkWell(
                child: Image.asset(LocalImages.ic_filter,height: 58.0,),
              )
            ],
          ),
        ),
      ),
      body: filteredItems.length>0?ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 48.0),
            child: ListTile(
              title: Text(filteredItems[index]),
              onTap: () {
                // Handle item tap
                print('Chọn: ${filteredItems[index]}');
              },
            ),
          );
        },
      ):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Không tìm thấy!', style: TextStyle(fontSize: 18,color: Colors.grey.shade500)),
            SizedBox(height: 20.0,),
            Image.asset(LocalImages.search_back,width: 200,),
          ],
        ),
      ),
    );
  }
}
