import 'package:flutter/material.dart';
import 'detail.dart';
import 'dart:convert';
import 'package:flutter/services.dart'
    show rootBundle; // Import the JSON package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multifunction_search',
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Orientation _orientation = Orientation.portrait;
  List<Map<String, dynamic>> displayList = [];
  bool ascendingOrder = true; // To track sorting order
  double _appBarHeight = 50.0; 
  double _searchBarHeight = 50.0; 


  Future<void> loadAndParseData() async {
    // Load JSON data from the asset file
    String jsonData = await rootBundle.loadString('assets/data.json');

    // Parse the JSON data into a list of maps
    List<dynamic> jsonList = json.decode(jsonData);

        setState(() {
      displayList = jsonList.map((item) {
        return {
          'id': item['id'],
          'Name': item['Name'],
          'School': item['School'],
          'Date Of Joining': item['Date Of Joining'],
        };
      }).toList();
    });
  }

   @override
    void initState() {
    super.initState();
    loadAndParseData(); // Load and parse data when the widget initializes
  }

    void sortList(bool ascending, String? sortBy) {
      setState(() {
        ascendingOrder = ascending;
        displayList.sort((a, b) {
          if (sortBy == "Name") {
            final nameA = a['Name']!.toLowerCase();
            final nameB = b['Name']!.toLowerCase();
            return ascending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
          } else if (sortBy == "Date Of Joining") {
            final dateA = DateTime.parse(a['Date Of Joining']!);
            final dateB = DateTime.parse(b['Date Of Joining']!);
            return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
          } else {
            return 0; // No sorting
          }
        });
      });
    }


    @override
    Widget build(BuildContext context) {
       // Check the current orientation
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (!isPortrait) {
      _appBarHeight = 40.0; 
      _searchBarHeight = 50.0; 
    }
      return OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 235, 190, 190),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_appBarHeight),
            child: AppBar(
              title: Center(
                child: Text(
                  "Search",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 30.0,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              backgroundColor: Color.fromARGB(255, 245, 18, 18),
              elevation: 0.0,
              actions: [
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    if (result == 'NameAtoZ') {
                      sortList(true, "Name");
                    } else if (result == 'NameZtoA') {
                      sortList(false, "Name");
                    } else if (result == 'DateJoiningAsc') {
                      sortList(true, "Date Of Joining");
                    } else if (result == 'DateJoiningDesc') {
                      sortList(false, "Date Of Joining");
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'NameAtoZ',
                      child: Text('Sort by Low To High'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'NameZtoA',
                      child: Text('Sort by High To Low'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'DateJoiningAsc',
                      child: Text('Joining Date (Asc)'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'DateJoiningDesc',
                      child: Text('Joining Date (Desc)'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 5.0),
                SizedBox(
                  
                  height: _searchBarHeight,
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        displayList = displayList
                            .where((item) =>
                                item['Name']!
                                    .toLowerCase()
                                    .contains(text.toLowerCase()) ||
                                item['School']!
                                    .toLowerCase()
                                    .contains(text.toLowerCase()))
                            .toList();
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 219, 120, 90),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search by name or school",
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.purple.shade900,
                    ),
                  ),
                ),
                // SizedBox(height: 5.0),
                Expanded(
                  child: displayList.length == 0
                      ? Center(
                          child: Text(
                            "No Results!-",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: ClampingScrollPhysics(), 
                                shrinkWrap: true ,
                                
                                  itemCount: displayList.length,
                                  itemBuilder: (context, index) => ListTile(
                                    title: Text(
                                      displayList[index]["Name"]!,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 122, 2, 2),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "School:${displayList[index]["School"]!}",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 5, 5, 5),
                                          ),
                                        ),
                                        Text(
                                          "Joining: ${displayList[index]["Date Of Joining"]!}",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            wordSpacing: 10.0,
                                            color: Color.fromARGB(255, 30, 21, 21),
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                ),
              ],
            ),
          ),
        );
      });
    }
  }

