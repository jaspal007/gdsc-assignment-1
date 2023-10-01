// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Potrait extends StatefulWidget {
  final String? searchQuery;
  const Potrait({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<Potrait> createState() => _PotraitState();
}

class _PotraitState extends State<Potrait> {

  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

    @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
    readJson();
  }
  String selectedSortOption = 'Relevance'; // Default sorting option
  List<dynamic> filteredItems = [];
  bool isEmpty = false;
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    _sortItems(selectedSortOption);

    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 1000,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (text) {
                  if (text == "") {
                    setState(() {
                      isEmpty = false;
                    });
                  } else {
                    setState(() {
                      isEmpty = true;
                      filteredItems = _items.where((product) =>
                              product[widget.searchQuery]
                                  .toLowerCase()
                                  .contains(text.toLowerCase()))
                          // .where((product) =>product["School"]
                          //           .toLowerCase()
                          //           .contains(text.toLowerCase()))
                          // .where((product) =>product["Date Of Joining"]
                          //           .toLowerCase()
                          //           .contains(text.toLowerCase()))

                          .toList();

                      //   filteredItems = items
                      //     .where((item) => item.toLowerCase().contains(text))
                      //     .toList();
                      // // Apply sorting based on the selected option
                      // _sortItems(selectedSortOption);
                    });
                  }
                },
                decoration: InputDecoration(
                  // hintText: 'Search...',
                  hintText: "Search by ${widget.searchQuery}",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            Container(
              color: Colors.amber,
              child: Center(
                child: DropdownButton<String>(
                  value: selectedSortOption,
                  // style: TextStyle(backgroundColor: Colors.greenAccent),
                  items: [
                    'Relevance',
                    'Low to High',
                    'High to Low',
                    'Date',
                  ].map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                      // Apply sorting based on the selected option
                      _sortItems(selectedSortOption);
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: isEmpty
                  ? ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final fill = filteredItems[index];
                        return Container(
                            padding: EdgeInsets.all(5),
                            height: 140,
                            child: Card(
                                elevation: 2.0,
                                margin: EdgeInsets.all(10.0),
                                color: Colors.greenAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ID : " + fill['id'],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "Name : " + fill['Name'],
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "School : " + fill['School'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Date Of Joining : " +
                                            fill['Date Of Joining'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                )));
                      },
                    )
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final user = _items[index];
                        return Container(
                          padding: EdgeInsets.all(5),
                          height: 140,
                          child: Card(
                              elevation: 2.0,
                              margin: EdgeInsets.all(10.0),
                              color: Colors.greenAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ID : " + user['id'],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      "Name : " + user['Name'],
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "School : " + user['School'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Date Of Joining : " +
                                          user['Date Of Joining'],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              )
                              // child: ListTile(
                              //   trailing: Text(
                              //     user['Date Of Joining'],
                              //     style: TextStyle(fontSize: 15),
                              //   ),
                              //   subtitle: Text(
                              //     user['School'],
                              //     style: TextStyle(fontSize: 16),
                              //   ),
                              //   title: Text(
                              //     user['Name'],
                              //     style: TextStyle(fontSize: 20),
                              //   ),
                              // ),
                              ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
void _sortItems(String option) {
    setState(() {
      switch (option) {
        case 'Relevance':
          // filteredItems
          //     .sort((a, b) => a["Relevance"].compareTo(a["Relevance"]));
          _items.sort((a, b) => a["Relevance"].compareTo(b["Relevance"]));

          // Implement relevance-based sorting if needed
          break;
        case 'Low to High':
          _items.sort((a, b) => a["Name"].compareTo(b["Name"]));

          filteredItems.sort((a, b) => a['Name'].compareTo(b["Name"]));
          break;
        case 'High to Low':
          _items.sort((a, b) => b["Name"].compareTo(a["Name"]));
          filteredItems.sort((a, b) => b['Name'].compareTo(a["Name"]));
          break;
        case 'Date':

          // Implement date-based sorting if needed
          filteredItems.sort(
              (a, b) => b["Date Of Joining"].compareTo(a["Date Of Joining"]));

          _items.sort((a, b) {
            DateTime dateA = DateTime.parse(a["Date Of Joining"]);
            DateTime dateB = DateTime.parse(b["Date Of Joining"]);
            return dateA.compareTo(dateB);
          });

          break;
        default:
          // Default sorting
          break;
      }
    });
  }
  
}




