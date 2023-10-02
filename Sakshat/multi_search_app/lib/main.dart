import 'dart:convert';
import 'package:flutter/material.dart';

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
  List<Info> information = [];
  List<Info> displayList = [];

  String? selectedSortCriteria;

  @override
  void initState() {
    super.initState();
    loadDataFromJson();
  }

  Future<void> loadDataFromJson() async {
    final jsonString =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonData = json.decode(jsonString);

    setState(() {
      information = jsonData.map<Info>((data) => Info.fromJson(data)).toList();
      displayList = List.from(information);
      // Sort the list by "Relevance" as the default
      sortList();
    });
  }

  void updateList(String value) {
    setState(() {
      value = value.toLowerCase();
      displayList = information.where((element) {
        final nameMatch = element.Name!.toLowerCase().contains(value);
        final idMatch = element.id!.toLowerCase().contains(value);
        final schoolMatch = element.School!.toLowerCase().contains(value);
        final dateMatch =
            element.Date_of_Joining!.toLowerCase().contains(value);
        return nameMatch || idMatch || schoolMatch || dateMatch;
      }).toList();
    });
  }

  void sortList() {
    if (selectedSortCriteria == "Relevance") {
      // Here, we'll keep the original order as it is.
      displayList.sort((a, b) => 0);
    } else if (selectedSortCriteria == "Low to High") {
      displayList.sort(
          (a, b) => a.Name!.toLowerCase().compareTo(b.Name!.toLowerCase()));
    } else if (selectedSortCriteria == "High to Low") {
      displayList.sort(
          (a, b) => b.Name!.toLowerCase().compareTo(a.Name!.toLowerCase()));
    } else if (selectedSortCriteria == "Date") {
      displayList.sort((a, b) => DateTime.parse(a.Date_of_Joining!)
          .compareTo(DateTime.parse(b.Date_of_Joining!)));
    }
  }

  Widget buildPortraitLayout(double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenWidth * 0.03),
        TextField(
          onChanged: (value) => updateList(value),
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white30,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Colors.white70,
            hintText: 'Enter details here...',
            hintStyle: TextStyle(
              fontFamily: "Poppins",
              letterSpacing: screenWidth * 0.005,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        Expanded(
          child: displayList.length == 0
              ? Center(
                  child: Text(
                    "No Results Found",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: (context, index) => Card(
                    elevation: screenWidth * 0.1,
                    color: Colors.black38,
                    child: ListTile(
                      title: Text(
                        displayList[index].Name!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayList[index].id!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            displayList[index].School!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            displayList[index].Date_of_Joining!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }

  Widget buildLandscapeLayout(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenWidth * 0.03),
              TextField(
                onChanged: (value) => updateList(value),
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white30,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.white70,
                  hintText: 'Enter details here...',
                  hintStyle: TextStyle(
                    fontFamily: "Poppins",
                    letterSpacing: screenWidth * 0.005,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          flex: 7,
          child: displayList.length == 0
              ? Center(
                  child: Text(
                    "No Results Found",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: (context, index) => Card(
                    elevation: screenWidth * 0.1,
                    color: Colors.black38,
                    child: ListTile(
                      title: Text(
                        displayList[index].Name!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayList[index].id!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            displayList[index].School!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            displayList[index].Date_of_Joining!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text("Search User "),
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            child: Text(
              "Sort by:",
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
          DropdownButton<String>(
            borderRadius: BorderRadius.circular(20.0),
            dropdownColor: Colors.cyanAccent,
            value: selectedSortCriteria,
            onChanged: (value) {
              setState(() {
                selectedSortCriteria = value;
                sortList();
              });
            },
            items: <String>[
              'Relevance',
              'Low to High',
              'High to Low',
              'Date',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return buildPortraitLayout(screenWidth);
          } else {
            return buildLandscapeLayout(screenWidth);
          }
        },
      ),
    );
  }
}

class Info {
  String? id;
  String? Name;
  String? School;
  String? Date_of_Joining;

  Info(this.id, this.Name, this.School, this.Date_of_Joining);

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      json['id'],
      json['Name'],
      json['School'],
      json['Date Of Joining'],
    );
  }
}
