 import 'package:flutter/material.dart';
import 'package:filter/model/product.dart'; // Import your data from product.dart

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.indigo),
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<String> categories = ['NAME', 'DOB', 'AGE'];
  String? selectedCategory;

  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SORT AND FILTER'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(personList: personList),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: personList.length,
        itemBuilder: (context, index) {
          final person = personList[index];
          return ListTile(
            title: Text(person.name),
            // You can add more details here if needed.
            // subtitle: Text("DOB: ${person.dateOfBirth}, Age: ${person.age}"),
            onTap: () {
              // Handle when a person is tapped.
            },
          );
        },
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<Person> personList;

  DataSearch({required this.personList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredPersons = personList
        .where((person) =>
            person.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredPersons.length,
      itemBuilder: (context, index) {
        final person = filteredPersons[index];
        return ListTile(
          title: Text(person.name),
          onTap: () {
            // Handle when a person is tapped.
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? personList.map((person) => person.name).toList()
        : personList
            .where((person) =>
                person.name.toLowerCase().contains(query.toLowerCase()))
            .map((person) => person.name)
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final suggestion = suggestionList[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
