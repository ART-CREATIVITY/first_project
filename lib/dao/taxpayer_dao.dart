import 'package:first_project/dao/database_access.dart';
import 'package:first_project/entities/taxpayer.dart';
import 'package:sqflite/sqflite.dart';

class TaxpayerDao {

  Future<Taxpayer> createTaxpayer(Taxpayer taxpayer) async{
    Database database = await DatabaseAccess().connect();
    Map<String, Object?> entity = {
      "firstName": taxpayer.firstName!,
      "lastName": taxpayer.lastName!,
      "gender": taxpayer.gender!=null?taxpayer.gender.toString():"",
      "phone": taxpayer.phone!,
      "email": taxpayer.email!,
      "birthDay": taxpayer.birthDay==null?'':taxpayer.birthDay!.toIso8601String(),
      "address": taxpayer.address!,
      "identifyPicture": taxpayer.identifyPicture!,
      "bornAround": taxpayer.bornAround==null?0:(taxpayer.bornAround!?1:0),
    };
    int id = await database.insert(Taxpayer.TABLE, entity);
    taxpayer.id = id;

    return taxpayer;
  }

  Future<List<Taxpayer>> findAll() async {
    Database database = await DatabaseAccess().connect();
    List<Map<String, Object?>> data = await database.query(Taxpayer.TABLE);

    return List.generate(data.length, (index){
      Taxpayer taxpayer = Taxpayer();
      Map<String, Object?> entity = data[index];
      taxpayer.firstName = entity["firstName"] as String;
      taxpayer.lastName = entity["lastName"] as String;
      taxpayer.address = entity["address"] as String;
      return taxpayer;
    });
  }
}