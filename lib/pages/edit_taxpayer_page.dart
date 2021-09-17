import 'package:flutter/material.dart';
import 'package:first_project/entities/taxpayer.dart';

class EditTaxpayerPage extends StatefulWidget {
  const EditTaxpayerPage({Key? key}) : super(key: key);

  @override
  _EditTaxpayerPageState createState() => _EditTaxpayerPageState();
}

class _EditTaxpayerPageState extends State<EditTaxpayerPage> {

  Gender? _gender = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creer un contribuable"),
      ),
      body: Form(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nom",
                  prefixIcon: Icon(Icons.person)
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Prenoms",
                    prefixIcon: Icon(Icons.person)
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SizedBox(width: 4,),
                  Icon(Icons.people, color: Colors.black54,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: DropdownButton<Gender>(
                      value: _gender,
                      onChanged: (Gender? newValue) {
                        setState(() {
                          _gender = newValue;
                        });
                      },
                      onTap: (){},
                        isExpanded: true,
                      underline: Container(),
                      items: Gender.values
                          .map((e){
                            String text = "";
                            switch(e){
                              case Gender.MALE:
                                text = "Masculin";
                                break;
                              case Gender.FEMALE:
                                text = "Feminin";
                                break;
                              case Gender.OTHER:
                                text = "Autre";
                                break;
                            }

                            return DropdownMenuItem(
                              value: e,
                                child: Text(text)
                            );
                      }).toList(),

                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    prefixIcon: Icon(Icons.alternate_email)
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Telephone",
                    prefixIcon: Icon(Icons.phone)
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Adresse",
                    prefixIcon: Icon(Icons.place)
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                minLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
