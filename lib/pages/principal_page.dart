import 'package:first_project/entities/taxpayer.dart';
import 'package:flutter/material.dart';

import 'edit_taxpayer_page.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  List<Taxpayer> _taxpayers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Principal Page"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push<Taxpayer>(context,
              MaterialPageRoute(
                  builder: (context) => const EditTaxpayerPage()
              )
          ).then((value) {
            if(value!=null) {
              _taxpayers.add(value);
            }
          });
        },
      ),
    );
  }
}
