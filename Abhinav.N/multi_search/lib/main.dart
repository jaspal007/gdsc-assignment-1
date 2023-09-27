import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      home: SearchPage(),
      debugShowCheckedModeBanner: false,
    ));

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String selectedSortOption = 'Relevance';
  List<Map<String, String>> displayList = [];
  List<Map<String, String>> filteredList = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/data.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    final List<Map<String, String>> dataList = jsonList.map((dynamic item) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      return {
        "id": itemMap["id"] as String,
        "Name": itemMap["Name"] as String,
        "School": itemMap["School"] as String,
        "Date Of Joining": itemMap["Date Of Joining"] as String,
      };
    }).toList();

    setState(() {
      displayList = dataList;
      filteredList = dataList;
    });
  }

  void updateList(String value) {
    setState(() {
      filteredList = displayList.where((item) {
        return (item["Name"]!.toLowerCase().contains(value.toLowerCase()) ||
            item["id"]!.toLowerCase().contains(value.toLowerCase()) ||
            item["School"]!.toLowerCase().contains(value.toLowerCase()) ||
            item["Date Of Joining"]!
                .toLowerCase()
                .contains(value.toLowerCase()));
      }).toList();

      sortDisplayList();
    });
  }

  void sortDisplayList() {
    setState(() {
      if (selectedSortOption == 'LowToHigh') {
        filteredList.sort((a, b) => a["Name"]!.compareTo(b["Name"]!));
      } else if (selectedSortOption == 'HighToLow') {
        filteredList.sort((a, b) => b["Name"]!.compareTo(a["Name"]!));
      } else if (selectedSortOption == 'Date') {
        filteredList.sort(
            (a, b) => a["Date Of Joining"]!.compareTo(b["Date Of Joining"]!));
      } else if (selectedSortOption == 'Relevance') {
        filteredList.sort((a, b) => 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;

        return Scaffold(
          backgroundColor: Colors.deepPurpleAccent,
          appBar: AppBar(
            title: Text("Search Bar"),
            centerTitle: true,
            backgroundColor: Colors.deepPurpleAccent,
            elevation: 0.0,
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Search and Sort-->',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${selectedSortOption}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) => updateList(value),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff302360),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: PopupMenuButton<String>(
                      onSelected: (String value) {
                        setState(() {
                          selectedSortOption = value;
                          sortDisplayList();
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Relevance',
                          child: Text('Relevance'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'LowToHigh',
                          child: Text('Low to High'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'HighToLow',
                          child: Text('High to Low'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Date',
                          child: Text('Date'),
                        ),
                      ],
                    ),
                    prefixIconColor: Colors.white,
                    suffixIconColor: Colors.white,
                    hintText: 'Enter here...',
                    hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      letterSpacing: .7,
                      height: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: filteredList.isEmpty
                      ? Center(
                          child: Text(
                            "No Results Found",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) => Card(
                            color: Colors.purple[900],
                            child: ListTile(
                              title: Text(
                                filteredList[index]["Name"]!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredList[index]["id"]!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    filteredList[index]["School"]!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    filteredList[index]["Date Of Joining"]!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
