import 'package:first_assignment/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isPressed = false;

  List persons = [];
  List original = [];
  TextEditingController txtQuery = TextEditingController();

  void loadData() async {
    String jsonStr = await rootBundle.loadString('assets/sample.json');
    var json = jsonDecode(jsonStr);
    persons = json;
    original = json;
    setState(() {});
  }

  void search(String query) {
    if (query.isEmpty) {
      persons = original;
      setState(() {});
      return;
    }

    query = query.toLowerCase();
    print(query);
    List result = [];
    for (var element in persons) {
      var name = element['Name'].toString().toLowerCase();
      var school = element['School'].toString().toLowerCase();
      if (name.contains(query) || school.contains(query)) {
        result.add(element);
      }
    }
    persons = result;
    setState(() {});
  }

  void sortName(bool sort) {
    setState(() {
      isPressed = sort;
      persons.sort((a, b) => sort
          ? a['Name'].compareTo(b['Name'])
          : b['Name'].compareTo(a['Name']));
    });
  }

  void sortDate(bool sort) {
    setState(() {
      isPressed = sort;
      persons.sort((a, b) => sort
          ? a['Date Of Joining'].compareTo(b['Date Of Joining'])
          : b['Date Of Joining'].compareTo(a['Date Of Joining']));
    });
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {
          sortName(!isPressed);
        });
        break;
      case 1:
        setState(() {
          sortDate(!isPressed);
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    txtQuery.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightblue1,
      appBar: AppBar(
        backgroundColor: lightblue1,
        title: const Text(
          "\tFirst_Assignment",
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
        actions: [
          PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onSelected: (value) => onSelected(context, value),
              itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Sort by Name"),
                          Icon(Icons.sort_by_alpha_rounded)
                        ],
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Sort by Date"),
                          Icon(Icons.date_range_rounded)
                        ],
                      ),
                    ),
                  ])
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "\tSearch & Sort Function",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: TextFormField(
                    controller: txtQuery,
                    onChanged: search,
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: lightblue2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: lightblue5),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: txtQuery.text.isEmpty
                          ? const SizedBox.shrink()
                          : IconButton(
                              onPressed: () {
                                txtQuery.text = "";
                                search(txtQuery.text);
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _listView(persons),
        ],
      ),
    );
  }
}

Widget _listView(persons) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.builder(
      itemCount: persons.length,
      itemBuilder: (context, index) {
        var person = persons[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: lightblue3,
          ),
          margin: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              //print(person['Name']);
              showDialog(
                barrierColor: Colors.black45,
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(person['Name']),
                  content: Text(
                      "School:  ${person['School']}\n\nDate of joining:  ${person['Date Of Joining']}"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("okay"),
                    ),
                  ],
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: lightblue4,
                child: Text(
                  person['Name'][0],
                  style: const TextStyle(color: lightblue5),
                ),
              ),
              title: Text(
                person['Name'],
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "School: ${person['School']}",
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 67, 87, 97)),
              ),
              trailing: Text(
                "\nDate: ${person['Date Of Joining'].substring(0, 10)}",
                style: const TextStyle(color: Color.fromARGB(255, 67, 87, 97)),
              ),
            ),
          ),
        );
      },
    ),
  ));
}
