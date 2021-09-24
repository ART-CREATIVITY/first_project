import 'package:flutter/material.dart';

class ResponsivityPage extends StatefulWidget {
  const ResponsivityPage({Key? key}) : super(key: key);

  @override
  _ResponsivityPageState createState() => _ResponsivityPageState();
}

class _ResponsivityPageState extends State<ResponsivityPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height/2;
    double w = size.width/2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Responsive"),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.green,
                    height: h/2 - 8,
                    width: w - 12,
                  ),
                  SizedBox(width: 8,),
                  Container(
                    color: Colors.yellow,
                    height: h/2 - 8,
                    width: w - 12,
                  )
                ],
              ),
              SizedBox(height: 8,),
              Container(
                color: Colors.red,
                height: h/2 - 8,
                width: size.width - 16,
                // constraints: BoxConstraints(m),
              )
            ],
          ),
        ),
      ),
    );
  }
}
