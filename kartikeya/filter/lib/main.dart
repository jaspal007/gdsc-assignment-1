 import 'package:flutter/material.dart';
import 'package:filter/model/product.dart';  

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
  bool isSortingByName = false;
  bool isSortingByAge = false;
  bool isSortingByDOB = false;

  @override
  Widget build(BuildContext context) {
    List<Person> sortedPersonList = [...personList];

    if (isSortingByName) {
      sortedPersonList.sort((a, b) => a.name.compareTo(b.name));
    } else if (isSortingByAge) {
      sortedPersonList.sort((a, b) => a.age.compareTo(b.age));
    } else if (isSortingByDOB) {
      sortedPersonList.sort((a, b) => a.dob.compareTo(b.dob));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SORT AND FILTER'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                isSortingByName = value == 'Name';
                isSortingByAge = value == 'Age';
                isSortingByDOB = value == 'DOB';
              });
            },
            itemBuilder: (BuildContext context) {
              return categories.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(personList: personList),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: sortedPersonList.length,
        itemBuilder: (context, index) {
          final person = sortedPersonList[index];
      return Container(
  margin: EdgeInsets.all(8),
  padding: EdgeInsets.all(8),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      color: Color.fromARGB(133, 156, 216, 233),
      child: ListTile(
        title: Center(
          child: Text(
            person.name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        subtitle: Center(
          child: Text(
            'DOB: ${person.dob.day}/${person.dob.month}/${person.dob.year}', // Format the DOB as needed
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ),
        onTap: () {
            
        },
      ),
    ),
  ),
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
