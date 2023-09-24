import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  // This widget is the root of your application.
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

class Contactinput{
  String? Contact_name;
  int? Number;
  Contactinput(this.Contact_name,this.Number);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}): super(key: key);


  // final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  static List<Contactinput> Contact_List=[
    Contactinput('Arnav',6208464464,),
    Contactinput("Pradeep",6209155222,),
    Contactinput("Rahul",6209156432,),
    Contactinput("Vikas",6208757567,),
    Contactinput("Raman",6208787567,),
    Contactinput("Vishal",6209757567,),
    Contactinput("Rajesh",6208227567,),
    Contactinput("Ramesh",6208765567,),
    Contactinput("yuvraj",6208758567,),
    Contactinput("Abhishek",6202357567,),
    Contactinput("ansh",6208734567,),
    Contactinput("Yash",6203357567,),
    Contactinput("Abhinav",6201757567,),
    Contactinput("ashutosh",6208957567,),
    Contactinput("shubham",6203957567,),
    Contactinput("rajnish",6208757522,),
    Contactinput("priyam",6208757357,),
    Contactinput("golden",6208752267,),
    Contactinput("deepak",6208757533,),
    Contactinput("sintu",6208757555,),
    Contactinput("ankit",6208757500,),
    Contactinput("anubhav",6208757508,),
    Contactinput("divyansh",6208757505,),

  ];

  //    create list that are going to display and filter
  List<Contactinput> display_List=List.from(Contact_List);
  void updateList(String value){
    //   this is the function that will filter our list
    setState(() {
      display_List=Contact_List.where((element) => element.Contact_name!.toLowerCase().contains(value.toLowerCase())).toList();


    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Search"),
      ),
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(

               onChanged:(value)=> updateList(value) ,
               style: TextStyle(
                 color: Colors.white70,
               ),
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderSide: BorderSide(
                     color:Colors.black87,
                   ),
                       borderRadius: BorderRadius.circular(0.0)
                 ),
                 prefixIcon: Icon(Icons.search),
                 hintText: "search your result"
               ),
               ),
           ),
          SizedBox(height: 20,),


            Expanded(
                child: ListView.builder(itemBuilder: (context,index){
                  return ListTile(
                contentPadding: EdgeInsets.all(8.0),
                leading:CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/boy.jpeg'),

                ),
                title: Text(display_List[index].Contact_name!,style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
                subtitle:Text("${display_List[index].Number!}",style: TextStyle(
                  color: Colors.amber,
                ),),
                trailing:CircleAvatar(
                    child: Icon(Icons.add)
                ),

              );


            },
            itemCount: display_List.length,

            )
            ),


        ],
      ),
    );
  }
}
