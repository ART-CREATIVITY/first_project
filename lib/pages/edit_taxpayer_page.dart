import 'dart:io';

import 'package:first_project/dao/taxpayer_dao.dart';
import 'package:first_project/web_service/web_service.dart';
import 'package:flutter/material.dart';
import 'package:first_project/entities/taxpayer.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class EditTaxpayerPage extends StatefulWidget {
  const EditTaxpayerPage({Key? key, this.taxpayer}) : super(key: key);
  final Taxpayer? taxpayer;

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String birthType = "KNOW";
  DateTime ?birthDay;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final ImagePicker _picker = ImagePicker();
  File ?image;
  TaxpayerDao taxpayerDao = new TaxpayerDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creer un contribuable"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatoire';
                    }
                    return null;
                  },
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
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatoire';
                    }
                    return null;
                  },
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              Radio<String>(
                                groupValue: birthType,
                                value: "KNOW",
                                onChanged: (v){
                                  setState(() {
                                    birthType=v!;
                                  });
                                },
                              ),
                              Text("Né(e) le")
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              birthType= "KNOW";
                            });
                          },
                        ),
                        InkWell(
                          child: Row(
                            children: [
                              Radio<String>(
                                groupValue: birthType,
                                value: "UNKNOW",
                                onChanged: (v){
                                  setState(() {
                                    birthType=v!;
                                  });
                                  },
                              ),
                              Text("Né(e) vers")
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              birthType= "UNKNOW";
                            });

                          },
                        ),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Date de naissance",
                            ),
                          ),
                          Align(
                            child: birthDay==null ?
                            OutlinedButton(onPressed: (){_defineDate(birthType=="KNOW");}, child: Text("Ajouter", style: TextStyle(color: Colors.black54),))
                                : InkWell(
                              onTap: (){_defineDate(birthType=="KNOW");},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "${formatter.format(birthDay!)}",
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                                ),
                              ),
                            ),
                            alignment: Alignment.bottomRight,
                          ),
                        ],
                      ),
                    )

                  ],
                )
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: InkWell(
                  child: image==null?Icon(Icons.camera, size: 92,):Image.file(image!),
                  onTap: () {
                    _picker.pickImage(source: ImageSource.gallery).then((value){
                      if(value==null) return;
                      image = File(value.path);
                    });
                  },
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
      ),
    );
  }

  save() async {
    if(!_formKey.currentState!.validate()){
      return;
    }
    taxpayer.firstName = _firstController.text;
    taxpayer.lastName = _lastController.text;
    taxpayer.gender = _gender;
    taxpayer.email = _emailController.text;
    taxpayer.address = _addressController.text;
    taxpayer.phone = _phoneController.text;
    taxpayer.birthDay = birthDay;
    if(image!=null) taxpayer.identifyPicture = image!.path;
    taxpayer.id = null;
    taxpayer = await taxpayerDao.createTaxpayer(taxpayer);
    WebService webService = WebService();
    var tax = await webService.createTaxpayer(taxpayer);
    print(tax);
    Navigator.pop(context, taxpayer);
  }

  void _defineDate(bool born) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(new Duration(days: 1825)),
      initialDate: birthDay??DateTime.now(),
      lastDate: DateTime.now(),
      initialDatePickerMode: born?DatePickerMode.day:DatePickerMode.year,
      // builder: (BuildContext context, Widget ?child) {
      //   return Theme(
      //     data: ThemeData.light(),
      //     child: child!,
      //   );
      // },
    ).then((date) async {
      if(date==null) return;
      setState(() {
        birthDay = date;
      });
    });
  }

}
