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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Search'),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NameListWidget(),
  ));
}
