import 'package:first_project/pages/principal_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PrincipalPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

enum ActionType { SETTINGS, PROFILE, THEMES }

class _FirstPageState extends State<FirstPage> {
  TextEditingController _textController = TextEditingController(text: "");
  List<String> _logs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text(
            "My First Page",
            style: TextStyle(
              // color: Colors.black,
              // fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        // backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _logs.add("Je clique sur mon action button");
                });
              },
              icon: Icon(Icons.settings)),
          PopupMenuButton<ActionType>(
            onSelected: (ActionType result) {
              setState(() {
                _logs.add('$result');
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<ActionType>>[
              const PopupMenuItem<ActionType>(
                value: ActionType.SETTINGS,
                child: Text('Parametre'),
              ),
              const PopupMenuItem<ActionType>(
                value: ActionType.PROFILE,
                child: Text('Profil'),
              ),
              const PopupMenuItem<ActionType>(
                value: ActionType.THEMES,
                child: Text('Themes'),
              ),
            ],
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    // obscureText: true, // permet de mettre le contenu text sous forme de password
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Log',
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _logs.add(_textController.text);
                      _textController.text = "";
                    });
                  },
                  child: Icon(Icons.add),
                )
              ],
            )
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, position) {

                  return InkWell(
                    child: _logs[position].startsWith("ActionType")
                      ? ActionItem(log: _logs[position])
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(_logs[position]),
                      ),
                    onTap: (){

                    },);
                },
                separatorBuilder: (context, position) {
                  return Divider(color: position%2==0?Colors.green:Colors.red,);
                },
                itemCount: _logs.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  final String log;
  const ActionItem({Key? key, required this.log}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: EdgeInsets.all(8),
      color: Colors.grey.withAlpha(100),
      child: Row(
        children: [
          Image.asset("assets/images/cover.jpeg", width: 150,),
          SizedBox(height: 16, width: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(log, style: Theme.of(context).textTheme.headline6,),
              Text(log),
            ],
          ),
        ],
      ),
    );
  }
}

