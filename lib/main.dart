import 'package:country_code_picker/country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_project/entities/taxpayer.dart';
import 'package:first_project/pages/code_verification_page.dart';
import 'package:first_project/pages/edit_taxpayer_page.dart';
import 'package:first_project/pages/login_page.dart';
import 'package:first_project/pages/principal_page.dart';
import 'package:first_project/utils/app_preferences.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppPreferences? preferences;
  String? initRoute;
  @override
  void initState() {
    // TODO: implement initState
    checkState();
    super.initState();
  }

  checkState()async {
    preferences = await AppPreferences.init();
    if(preferences!.checkLogin()){
      initRoute = "home";
    } else {
      initRoute = "login";
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return initRoute==null? Container() : MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: PrincipalPage(),
      initialRoute: initRoute,
      onGenerateRoute: (settings){
        switch(settings.name) {
          case "home" :
            return MaterialPageRoute(builder: (context)=>PrincipalPage());
          case "login":
            return MaterialPageRoute(builder: (context)=>LoginPage());
          case "login/verification":
            Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (context)=>CodeVerificationPage(code: map["code"] as CountryCode,
                phone: map["phone"] as String, verificationId: map["verificationId"] as String
              , resendToken: map["resendToken"] as int,
            ));
          case "taxpayers/create":
            return MaterialPageRoute(builder: (context)=>EditTaxpayerPage());
          case "taxpayers/update":
            return MaterialPageRoute(builder: (context)=>EditTaxpayerPage(taxpayer: settings.arguments as Taxpayer,));
        }
      },
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

