import 'package:flutter/material.dart';
import 'package:multi_search/components/landescapeLayout.dart';
import 'package:multi_search/components/potraitLayout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? searchQuery = "Name";
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search & Sort App'),
        actions: [
          // Create the "More" icon with the popup menu
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle the selected menu item here
              print("Selected: $value");
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: searchQuery,
                child: Text("Search By Name"),
                onTap: () {
                  searchQuery = "Name";
                },
              ),
              PopupMenuItem<String>(
                value: searchQuery,
                child: Text("Search By School"),
                onTap: () {
                  setState(() {
                    searchQuery = "School";
                  });
                },
              ),
              PopupMenuItem<String>(
                value: searchQuery,
                child: Text("Search By Date"),
                onTap: () {
                  setState(() {
                    searchQuery = "Date Of Joining";
                  });
                },
              ),
            ],
          ),
        ],
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         setState(() {});
        //       },
        //       icon: Icon(Icons.search)),
        //   IconButton(
        //       onPressed: () {

        //       },
        //       icon: Icon(Icons.more_vert)),
        // ],
      ),
      body: isLandscape ? Landescape(searchQuery: searchQuery,) : Potrait(searchQuery: searchQuery,),
    );
  }
}
