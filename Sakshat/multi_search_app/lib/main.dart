import 'dart:ui';

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
  static List<Info> information = [
    Info("bc929f27-3cdb-3d66-b1e4-b644bab92d5d", "Mr. Judge McClure",
        "Wolf-Abshire", "1985-08-27 13:36:09"),
    Info("2c2f5705-5285-3f27-a3ec-5fc9f0bf893f", "Emilia Keebler",
        "Stracke-Gulgowski", "1970-03-19 23:37:54"),
    Info("b0bc7502-c76b-3f65-a3d5-e748b00aa609", "Theodore Gutkowski",
        "Stokes-Lakin", "2010-10-11 03:36:05"),
    Info("7d7e7713-d9f4-33ca-bcfd-b928a09dff52", "Arno Daniel",
        "Gorczany-Schulist", "1997-04-24 13:29:27"),
    Info("19eb6427-05cf-3d27-8832-b5bdb13289e4", "Michele Hudson",
        "Altenwerth-Macejkovic", "2008-03-18 00:11:32"),
    Info("e40f932b-d894-3703-a88d-6a6f1b74581b", "Mr. Kevin Lueilwitz",
        "Bode Ltd", "2013-08-19 12:01:46"),
    Info("38e044c2-33b4-31e6-95e4-df2da09d9eea", "Tessie Crona",
        "Krajcik, Raynor and Rath", "1984-04-01 07:43:46"),
    Info("f8940ed6-4dc4-393a-bb55-f4d2eaca03bf", "Mrs. Dominique Hahn IV",
        "O'Hara, Jones and Oberbrunner", "2011-03-08 09:39:06"),
    Info("1117668b-34d5-307c-a8a9-936c6be7bb92", "Elvis Block",
        "Volkman and Sons", "2016-06-03 06:11:47"),
    Info("92ab3b2c-d0dd-3143-ae06-0c4bc8b349af", "Moises Spinka",
        "Cassin Group", "1975-05-25 11:03:49"),
    Info("563009ee-bf1a-3456-9071-4febc1d110e5", "Dr. Jess Walsh",
        "Conroy-Rohan", "1991-09-26 02:28:30"),
    Info("1d992500-c629-3c17-a973-3e6dd0077e2a", "Bernardo Klocko",
        "Conn, Leannon and Zulauf", "1977-07-29 12:19:19"),
    Info("75eca9e0-8e92-33e5-8fdf-e61265a6eeb9", "Jayda Hermann I",
        "Wehner, Hodkiewicz and Bradtke", "2009-04-20 16:44:45"),
    Info("813c69ae-1b2e-3dda-8d15-002c81440502", "Selina Jones Jr.",
        "Littel-Schowalter", "1973-04-15 12:17:47"),
    Info("0af52105-5fe6-3611-b982-dbc0a4d354d1", "Alison Aufderhar",
        "Leannon-Strosin", "1990-01-14 21:18:46"),
    Info("a2603965-be51-3d58-b754-ca3fb77250ea", "Celestine Jast",
        "Wilderman LLC", "2008-10-01 04:14:33"),
    Info("16c2c68b-2bae-3a87-b607-2e9ab620aea2", "Prof. Kobe Abbott",
        "Ritchie-Mraz", "2012-12-14 08:26:50"),
    Info("380d1f95-3a7f-38c5-ac2b-4fcdd8e44f22", "Jarrell Sawayn III",
        "Dickinson Inc", "1989-10-20 08:07:08"),
    Info("17120da0-7717-3697-99df-885daf2f6a95", "Mrs. Eleonore Rempel",
        "Konopelski-Ziemann", "1999-04-15 22:48:25"),
    Info("a869cc2b-c143-3c9d-96e0-ef765c5991b8", "Miss Amara Nikolaus",
        "Stamm-Bruen", "2012-10-13 13:27:48"),
    Info("25365674-8089-3fa7-8101-e9e220e88ee7", "Mohammad Welch",
        "Farrell-Jones", "1998-04-19 22:19:10"),
    Info("46c7a448-9c6e-326b-9ff9-6bc1d18501ec", "Anya Witting DVM",
        "Witting, Breitenberg and Frami", "2012-12-09 07:40:45"),
    Info("547d6a35-3887-3db6-afb8-15014278c335", "Jayme Bode DVM",
        "Powlowski, Moore and Adams", "2022-02-02 01:26:47"),
    Info("1afb0673-98e8-3622-8705-afef7909bd0a", "Dr. Ashlynn Thiel II",
        "Walker-Dickinson", "1999-05-04 23:45:44"),
    Info("ae2574b7-cc4a-3c23-8440-d48058a9d712", "Ms. Jessika Kuvalis Sr.",
        "Moen LLC", "2023-05-26 10:25:34"),
  ];

  List<Info> displayList = List.from(information);

  String? selectedSortCriteria;

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
              Text(
                'Search by Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                  hintText: 'Enter the name here...',
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
}
