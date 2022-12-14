import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'itemList.dart' as globals;


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: const HomePage(), routes: <String, WidgetBuilder>{
    "/HomePage": (BuildContext context) => const HomePage(),
    "/createNew": (BuildContext context) => const createNew(),
    "/editExisting": (BuildContext context) => const editExisting(),
    "/repository": (BuildContext context) => const repository(),
  }));
}

//first page
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// --------------------- for reading JSON file
  List _magicItems = [];
  //fetch content from json file
  Future<void> readJson() async {
    final String response =
    await rootBundle.loadString("assets/magic_items.json");
    final data = await json.decode(response);

    setState(() {
      _magicItems = data;
    });
  }


//------------------------------ ABOUT PAGE, FIRST TAB INDEX
  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <
    Widget
    >[
    Container(
    decoration: const BoxDecoration(
    //image: DecorationImage(
   // image: AssetImage("images/d20.jpg"), fit: BoxFit.contain),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: ListView(
    children: const [
    Text("About Page", textAlign: TextAlign.center),
    Center(

    child: Text("Hello, welcome to my D&D magic item creator. I wanted"
    "to make an app to solve a specific problem I've had. First, when making homebrew items for my players, "
    "I want to have the item in a visual, easily accesible format, so I would make cards with an online generator."
    "However, it was limited, and the formatting left much to be desired. So I decided to make an app that will record all the data"
    "for me. Hopefully I will have it able to spit out cards, but at least I can jot down ideas quickly when inspiration strikes. ")


    )
    ]
    )
    ),

//------------------ TAB INDEX SECOND PAGE, HOME ----------------->>
    Container(
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/d20.jpg"), fit: BoxFit.contain),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: ListView(
    children: [
    Text("Main Menu", textAlign: TextAlign.center),
    Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    const Text("\nMain Menu",
    style: TextStyle(fontSize: 24.0)),
    const Divider(
    height: 20, thickness: 1, color: Colors.blue),
    IconButton(
    icon: const Icon(Icons.add, color: Colors.red),
    iconSize: 70,
    onPressed: () {
    Navigator.of(context).pushNamed("/createNew");
    }),
    const Text("Create New Item"),
    IconButton(
    icon: const Icon(Icons.edit, color: Colors.yellow),
    iconSize: 70,
    onPressed: () {
    Navigator.of(context).pushNamed("/editExisting");
    }),
    const Text("Edit Existing Item"),
    IconButton(
    icon: const Icon(Icons.folder,
    color: Colors.orangeAccent),
    iconSize: 70,
    onPressed: () {
    Navigator.of(context).pushNamed("/repository");
    }),
    const Text("Item Repository"),
    ]))
    ],
    )),

      // ----------------------- 3RD INDEX, MAGIC ITEM SRD JSON --------------------
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Text("Magic items from the core rulebooks to give you some ideas!"),

          ElevatedButton(child: const Text('Load Data'), onPressed: readJson),
          _magicItems.isNotEmpty
              ? Expanded(
              child: ListView.builder(
                  itemCount: _magicItems.length,
                  itemBuilder: (context, index) {
                    //example with card
                    return
                      (
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${_magicItems[index][0]} "),
                                Text("Description ${_magicItems[index][1]}"),
                                const Divider(height: 10, thickness: 3, color: Colors.indigo)

                              ],
                            ),
                          )

                      );
                  }))
              : Container()
        ]),
      )

    ];

    //END TAB WIDGET LIST ------------------------






    return MaterialApp(
    home: DefaultTabController(
    initialIndex: 1,
    length: 3,
    child: Scaffold(

    appBar: AppBar(

    title: Text("D&D Magic Item Creator"),
    bottom: const TabBar(
    tabs: [
    Tab(icon: Icon(Icons.info)),
    Tab(icon: Icon(Icons.home_filled)),
    Tab(icon: Icon(Icons.folder)),
    ]),

    backgroundColor: Colors.red),

    body: TabBarView(children: _widgetOptions, ),

    ),
    /*bottomNavigationBar: BottomNavigationBar(
        items: const[
          BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: 'Home',
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(Icons.Pen),
              label: 'Create New',
              backgroundColor: Colors.yellowAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Message',
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_city),
              label: 'Cities',
              backgroundColor: Colors.teal),


        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,

      ),*/
    )
    );
  }
}

//return a widget to make formatting easier
class Items extends State {
  String itemName = "";
  String itemDesc = "";

  /*
  String itemType = "";
  String itemAttunement = "";
  String itemCost = "";
  String itemText = "";
*/
  Items(this.itemName, this.itemDesc);

  //this.itemType, this.itemAttunement, this.itemCost, this.itemText);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

//2nd page
class createNew extends StatefulWidget {
  const createNew({Key? key}) : super(key: key);

  @override
  _createNew createState() => _createNew();
}

//THIS MIGHT NEED TO BE IN A DIFFERENT CLASS??
//IDK MIGHT BE BETTER OUT HERE ON IT'S OWN
class _createNew extends State<createNew> {
  static TextEditingController nameCon = TextEditingController();
  static TextEditingController descCon = TextEditingController();
  String submissionStatus = "Item submission pending";

  /*
  static TextEditingController controller3 = TextEditingController();
  static TextEditingController controller4 = TextEditingController();
  static TextEditingController controller5 = TextEditingController();
  static TextEditingController controller6 = TextEditingController();
*/
  _submit() {
    Items newSubmisson = new Items(nameCon.text, descCon.text,);

    globals.itemList.add(newSubmisson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a new Item")),
      body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("images/pennquill.jpg"), fit: BoxFit.cover),
          ),
          padding: EdgeInsets.all(30.0),
          child: Column(children: [
            Text(submissionStatus),
            Expanded(child: entry1),
            Expanded(child: entry2),

            /* going to work with just 2 text controllers for right now
            Expanded(child: entry3),
            Expanded(child: entry4),
            Expanded(child: entry5),
            Expanded(child: entry6),

             */
          ])),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            setState(() {
              _submit();
              FocusManager.instance.primaryFocus?.unfocus();
              submissionStatus =
              "Item submitted! Please weight as we move you to the next page.";
              Timer(Duration(seconds: 3), () {
                Navigator.of(context).pushNamed("/repository");
              });
            }),
        tooltip: 'Submit button',
        child: const Icon(Icons.subdirectory_arrow_right_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget entry1 = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      const Text("Item Name:"),
      Container(
          width: 150.0,
          height: 60.0,
          padding: EdgeInsets.all(5.0),
          child: TextField(
            maxLines: 8, //or null
            decoration: const InputDecoration.collapsed(
                border: OutlineInputBorder(), hintText: "Enter your text here"),
            controller: nameCon,
            keyboardType: TextInputType.text,
          ))
    ],
  );

//1st text entry field

  Widget entry2 = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      const Text("Item Description:"),
      Container(
          width: 150.0,
          height: 60.0,
          padding: EdgeInsets.all(5.0),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Description ",
            ),
            controller: descCon,
            keyboardType: TextInputType.text,
          ))
    ],
  );

//2nd text entry field

  /*  (keeping it simple and using only 2 text fields for the time being.


  Widget entry3 = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      Text("Item Type:"),
      Container(
          width: 150.0,
          height: 60.0,
          padding: EdgeInsets.all(5.0),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Type ",
            ),
            controller: controller3,
            keyboardType: TextInputType.text,
          ))
    ],
  );

//3rd text entry field

  Widget entry4 = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      Text("Item Attunement:"),
      Container(
          width: 150.0,
          height: 60.0,
          padding: EdgeInsets.all(5.0),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "name ",
            ),
            controller: controller4,
            keyboardType: TextInputType.text,
          ))
    ],
  );

//4ths text entry field

  Widget entry5 = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      Text("Item Cost:"),
      Container(
          width: 150.0,
          height: 60.0,
          padding: EdgeInsets.all(5.0),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Cost ",
            ),
            controller: controller5,
            keyboardType: TextInputType.text,
          ))
    ],
  );

//5th text entry field

  Widget entry6 = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      Text("Item Text:"),
      Container(
          width: 150.0,
          height: 60.0,
          padding: EdgeInsets.all(5.0),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "rules go here ",
            ),
            controller: controller6,
            keyboardType: TextInputType.text,
          ))
    ],
  );

//6th text entry field
*/

  void dispose() {
    nameCon.dispose();
    descCon.dispose();

    /*controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
*/
  }
}

//MAKE EDIT PAGE

//3rd page
class editExisting extends StatefulWidget {
  const editExisting({Key? key}) : super(key: key);

  @override
  _editExisting createState() => _editExisting();
}

//THIS MIGHT NEED TO BE IN A DIFFERENT CLASS??
//IDK MIGHT BE BETTER OUT HERE ON IT'S OWN
class _editExisting extends State<editExisting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Edit Existing Item")),
        body: ListView(
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("images/construction.jpg"),
                        fit: BoxFit.fitHeight)),
                padding: EdgeInsets.all(20.0),
                child: Column(children: [
                  Text("Under Construction!"),
                ]))
          ],
        ));
  }
}


//4th page
class repository extends StatefulWidget {
  const repository({Key? key}) : super(key: key);

  @override
  _repository createState() => _repository();
}

//THIS MIGHT NEED TO BE IN A DIFFERENT CLASS??
//IDK MIGHT BE BETTER OUT HERE ON IT'S OWN
class _repository extends State<repository> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Repository")),
        body: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("images/scroll.jpg"),
                    fit: BoxFit.fitWidth)),
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: (globals.itemList.length),
              itemBuilder: (BuildContext context, int index) {
                return (ListTile(
                    title: Text(globals.itemList[index].itemName.toString()),
                    subtitle: Text(
                        globals.itemList[index].itemDesc.toString())));
              },


            )
        )
    );
  }


}

