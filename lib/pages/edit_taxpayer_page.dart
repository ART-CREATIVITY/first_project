import 'package:flutter/material.dart';
import 'package:first_project/entities/taxpayer.dart';

class EditTaxpayerPage extends StatefulWidget {
  const EditTaxpayerPage({Key? key}) : super(key: key);

  @override
  _EditTaxpayerPageState createState() => _EditTaxpayerPageState();
}

class _EditTaxpayerPageState extends State<EditTaxpayerPage> {

  Gender? _gender = null;
  Taxpayer taxpayer = Taxpayer();
  TextEditingController _firstController = TextEditingController();
  TextEditingController _lastController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
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
                controller: _lastController,
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
                controller: _firstController,
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
                controller: _emailController,
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
                controller: _phoneController,
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
                controller: _addressController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Adresse",
                    prefixIcon: Icon(Icons.place)
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                minLines: 1,
              ),
            ),
            Container(
              width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: ElevatedButton(
                    onPressed: save,

                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Enregistrer", style: TextStyle(fontSize: 18)),
                    )))
          ],
        ),
      ),
    );
  }

  save() {
    taxpayer.firstName = _firstController.text;
    taxpayer.lastName = _lastController.text;
    taxpayer.gender = _gender;
    taxpayer.email = _emailController.text;
    taxpayer.address = _addressController.text;
    taxpayer.phone = _phoneController.text;
    Navigator.pop(context, taxpayer);
  }
}
