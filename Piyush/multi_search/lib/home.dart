import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_search/catalog.dart';

class NameListWidget extends StatefulWidget {
  @override
  _NameListWidgetState createState() => _NameListWidgetState();
}

class _NameListWidgetState extends State<NameListWidget> {
  List<Person> people = [];
  List<Person> _filteredpeople = [];
  TextEditingController _searchcontroller = TextEditingController();
  String dropdownvalue = "Name";
  String searchQuery = '';
  var items = ['Name', 'School', 'Date'];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await rootBundle.loadString('Assets/files/sample.json');
    final List<dynamic> jsonList = json.decode(data);
    final List<Person> personList =
        jsonList.map((json) => Person.fromJson(json)).toList();

    setState(() {
      people = personList;
      _filteredpeople = people;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Search'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.teal))),
                  onChanged: searchppl,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: DropdownButton(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(10),
                  padding: EdgeInsets.all(8),
                  value: dropdownvalue,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      child: Text(items),
                      value: items,
                    );
                  }).toList(),
                  onChanged: (String? newvalue) {
                    dropdownvalue = newvalue!;
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredpeople.length,
              itemBuilder: (context, index) {
                // var sortedpeople = people
                //   ..sort((people1, people2) => people1.compareTo(people2));
                final person = _filteredpeople[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.teal,
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(
                        person.name,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text('School: ${person.school}'),
                      trailing: Text("Date : ${person.date}"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // void searchppl(String query) {
  //   final suggestion = people.where((Person) {
  //     final name = Person.date.toLowerCase();
  //     final input = query.toLowerCase();
  //     return name.contains(input);
  //   }).toList();

  //   setState(() => people = suggestion);
  // }
  void searchppl(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
      _filteredpeople = people.where((Person) {
        switch (dropdownvalue) {
          case 'Name':
            return Person.name.toLowerCase().contains(searchQuery);
          case 'School':
            return Person.school.toLowerCase().contains(searchQuery);
          case 'Date':
            return Person.date.toLowerCase().contains(searchQuery);
          default:
            return false;
        }
      }).toList();
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: NameListWidget(),
  ));
}
