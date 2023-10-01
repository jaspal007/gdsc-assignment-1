import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class Student_input {
  String? id;
  String? Name;
  String? School;
  String? Date_Of_Joining;

  Student_input(this.id, this.Name, this.School, this.Date_Of_Joining);

  factory Student_input.fromJson(Map<String, dynamic> json) {
    return Student_input(
      json['id'],
      json['Name'],
      json['School'],
      json['Date_Of_Joining'],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Student_input> Student_List = [];
  List<Student_input> display_List = [];

  @override
  void initState() {
    super.initState();
    loadStudentData();
  }

  Future<void> loadStudentData() async {
    final String jsonString = await rootBundle.loadString('assets/students.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    Student_List = jsonData.map((json) => Student_input.fromJson(json)).toList();
    setState(() {
      display_List = List.from(Student_List);
    });
  }

  void updateList(String value) {

    // if (value.trim().isEmpty) {
    //   setState(() {
    //     display_List = Student_List;
    //   });
    //   return;
    // }

    setState(() {
      display_List = Student_List.where((element) =>
      (element.Name?.toLowerCase() ?? '').contains(value.toLowerCase()) ||
          (element.id?.toLowerCase() ?? '').contains(value.toLowerCase()) ||
          (element.School?.toLowerCase() ?? '').contains(value.toLowerCase()) ||
          (element.Date_Of_Joining?.toLowerCase() ?? '').contains(value.toLowerCase())
      ).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Search"),
      ),
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => updateList(value),
              style: const TextStyle(
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black87,
                  ),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: "search your result",
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: Text(
                    display_List[index].School ?? "Unknown", // Default to "Unknown" if null
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selectedTileColor: Colors.cyanAccent,
                  title: Text(
                    display_List[index].Name ?? "Unknown",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    display_List[index].id ?? "Unknown",
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                  trailing: Text(
                    display_List[index].Date_Of_Joining ?? "Unknown",
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                );
              },
              itemCount: display_List.length,
            ),

          ),
        ],
      ),
    );
  }
}
