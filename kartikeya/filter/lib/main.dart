 
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.indigo),
      home: const ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

 class _ProductListPageState extends State<ProductListPage> {
  final List<String> categories = ['Food', 'Fruit', 'Drink'];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SORT AND FILTER'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
           
              hint: const Text('Select Category' , style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),)),
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
       
       

        ],
      ),
    );
  }
}
