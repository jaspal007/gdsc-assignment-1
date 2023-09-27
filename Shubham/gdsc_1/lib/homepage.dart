import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var menu = ["Name", "School", "Date Of Joining"];
  List result = [];
  List items = [];
  var dropdownvalue = "Name";
  bool asc = true;
  bool ascOption = true;

  Future<String> loadData() async {
    var data = await rootBundle.loadString("assets/sample.json");

    setState(() {
      items = json.decode(data);
      result = items;

      //items.sort((a, b) => b["Name"].compareTo(a["Name"]));
    });
    return "done";
  }

  @override
  void initState() {
    // TODO: implement initState
    this.loadData();

    super.initState();
    result = items;
  }

  void results(String val) {
    setState(() {});
    if (val.isEmpty) {
      result = items;
    } else {
      result = items
          .where(
              (user) => user["Name"].toLowerCase().contains(val.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        /* appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Center(
              child: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          )),
        ), */
        body: Column(
          children: [
            (orientation == Orientation.portrait)
                ? Container(
                    //err color: Colors.red,
                    height: (orientation == Orientation.portrait)
                        ? media.size.height * 0.2
                        : media.size.height * 0.4,
                    child: Column(
                      children: [
                        Container(
                          width: media.size.width * 0.9,
                          height: media.size.height * .1,
                          child: Center(
                            child: TextField(
                              onChanged: (value) => results(value),
                              decoration: InputDecoration(
                                  hintText: "Enter Here to search",
                                  suffixIcon: Icon(Icons.search)),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      ascOption = !ascOption;
                                      if (!ascOption)
                                        result.sort((a, b) => b[dropdownvalue]
                                            .compareTo(a[dropdownvalue]));
                                      else
                                        result.sort((a, b) => a[dropdownvalue]
                                            .compareTo(b[dropdownvalue]));
                                    });
                                  },
                                  child: ascOption
                                      ? Text(
                                          "Ascending",
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : Text(
                                          "Descending",
                                          style: TextStyle(color: Colors.black),
                                        )),
                              DropdownButton(
                                value: dropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: menu.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownvalue = value!;
                                    ascOption
                                        ? result.sort((a, b) => a[dropdownvalue]
                                            .compareTo(b[dropdownvalue]))
                                        : result.sort((a, b) => b[dropdownvalue]
                                            .compareTo(a[dropdownvalue]));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    //color: Colors.green,
                    height: media.size.height * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: media.size.width * 0.45,
                          height: media.size.height * 0.2,
                          child: Center(
                            child: TextField(
                              onChanged: (value) => results(value),
                              decoration: const InputDecoration(
                                  hintText: "Enter Here to search",
                                  suffixIcon: Icon(Icons.search)),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      ascOption = !ascOption;
                                      if (!ascOption)
                                        result.sort((a, b) => b[dropdownvalue]
                                            .compareTo(a[dropdownvalue]));
                                      else
                                        result.sort((a, b) => a[dropdownvalue]
                                            .compareTo(b[dropdownvalue]));
                                    });
                                  },
                                  child: ascOption
                                      ? Text(
                                          "Ascending",
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : Text(
                                          "Descending",
                                          style: TextStyle(color: Colors.black),
                                        )),
                              DropdownButton(
                                value: dropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: menu.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownvalue = value!;
                                    ascOption
                                        ? result.sort((a, b) => a[dropdownvalue]
                                            .compareTo(b[dropdownvalue]))
                                        : result.sort((a, b) => b[dropdownvalue]
                                            .compareTo(a[dropdownvalue]));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            Expanded(
              child: ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      height: 70,
                      color: Colors.amber[100],
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(result[index]["Name"]),
                            Text(result[index]["Date Of Joining"])
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(result[index]["School"]),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
