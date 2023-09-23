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
  String selectedSortOption = 'Relevance';

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
        "Altenwerth-Macejkovic", "2008-03-1800:11:32"),
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

  List<Info> display_list = List.from(information);

  void updateList(String value) {
    setState(() {
      display_list = information.where((element) {
        final nameMatches =
            element.Name!.toLowerCase().contains(value.toLowerCase());
        final idMatches =
            element.id!.toLowerCase().contains(value.toLowerCase());
        final schoolMatches =
            element.School!.toLowerCase().contains(value.toLowerCase());
        final dateMatches = element.Date_of_Joining!
            .toLowerCase()
            .contains(value.toLowerCase());

        return nameMatches || idMatches || schoolMatches || dateMatches;
      }).toList();
      sortDisplayList();
    });
  }

  void sortDisplayList() {
    setState(() {
      if (selectedSortOption == 'LowToHigh') {
        display_list.sort((a, b) => a.Name!.compareTo(b.Name!));
      } else if (selectedSortOption == 'HighToLow') {
        display_list.sort((a, b) => b.Name!.compareTo(a.Name!));
      } else if (selectedSortOption == 'Date') {
        display_list
            .sort((a, b) => a.Date_of_Joining!.compareTo(b.Date_of_Joining!));
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
                      'Search',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 500,),
                    Text("${selectedSortOption}",style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),),
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
                  child: display_list.length == 0
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
                          itemCount: display_list.length,
                          itemBuilder: (context, index) => Card(
                            color: Colors.purple[900],
                            child: ListTile(
                              title: Text(
                                display_list[index].Name!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    display_list[index].id!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    display_list[index].School!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    display_list[index].Date_of_Joining!,
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

class Info {
  String? id;
  String? Name;
  String? School;
  String? Date_of_Joining;

  Info(this.id, this.Name, this.School, this.Date_of_Joining);
}
