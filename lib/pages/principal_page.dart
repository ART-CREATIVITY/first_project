import 'dart:io';

import 'package:first_project/dao/taxpayer_dao.dart';
import 'package:first_project/entities/taxpayer.dart';
import 'package:first_project/web_service/taxpayer_web_service.dart';
import 'package:first_project/web_service/web_service.dart';
import 'package:flutter/material.dart';

import 'edit_taxpayer_page.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  List<Taxpayer> _taxpayers = [];
  TaxpayerDao taxpayerDao = new TaxpayerDao();
  bool loading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Principal Page"),
      ),
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _taxpayers.isEmpty
                ? Center(
                    child: Text("Aucun contribuable enregistre"),
                  )
                : SingleChildScrollView(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, position) {
                        Taxpayer taxpayer = _taxpayers[position];
                        return Container(
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (taxpayer.identifyPicture == null ||
                                    taxpayer.identifyPicture!.isEmpty)
                                  Center(
                                      child: SizedBox(
                                    child: Icon(Icons.image),
                                    height: 150,
                                  )),
                                if (taxpayer.identifyPicture != null &&
                                    taxpayer.identifyPicture!.isNotEmpty)
                                  Container(
                                    child: Image.file(
                                        File(taxpayer.identifyPicture!)),
                                    height: 50,
                                  ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${taxpayer.firstName} ${taxpayer.lastName}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "${taxpayer.email}",
                                      ),
                                      Text(
                                        "${taxpayer.phone}",
                                      ),
                                      Text(
                                        "${taxpayer.birthDay}",
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: _taxpayers.length,
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push<Taxpayer>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditTaxpayerPage()))
              .then((value) {
            if (value != null) {
              print(value);
              _taxpayers.add(value);
            }
          });
        },
      ),
    );
  }

  loadData() async {
    // await taxpayerDao.deleteById(1);
    _taxpayers = await taxpayerDao.findAll();
    setState(() {
      loading = false;
    });

    // WebService webService = WebService();
    // webService.getAll().then((value) => print(value));
    TaxpayerWebService taxpayerWebService = WebService.getTaxpayerWebService();
    taxpayerWebService.getAll().then((value) => print(value));
  }
}
