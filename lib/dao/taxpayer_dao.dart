import 'package:first_project/dao/database_access.dart';
import 'package:first_project/entities/taxpayer.dart';
import 'package:sqflite/sqflite.dart';

class TaxpayerDao {

  Future<Taxpayer> createTaxpayer(Taxpayer taxpayer) async{
    Database database = await DatabaseAccess().connect();
    // Map<String, Object?> entity = {
    //   "firstName": taxpayer.firstName!,
    //   "lastName": taxpayer.lastName!,
    //   "gender": taxpayer.gender!=null?taxpayer.gender.toString():"",
    //   "phone": taxpayer.phone!,
    //   "email": taxpayer.email!,
    //   "birthDay": taxpayer.birthDay==null?'':taxpayer.birthDay!.toIso8601String(),
    //   "address": taxpayer.address!,
    //   "identifyPicture": taxpayer.identifyPicture,
    //   "bornAround": taxpayer.bornAround==null?0:(taxpayer.bornAround!?1:0),
    // };
    Map<String, Object?> entity = taxpayer.toJson();
    int id = await database.insert(Taxpayer.TABLE, entity);
    taxpayer.id = id;

    return taxpayer;
  }

  Future<List<Taxpayer>> findAll({String search="", Gender? gender, DateTime? start, DateTime? end}) async {
    Database database = await DatabaseAccess().connect();
    search = '%$search%';
    String where = "firstName like ? OR lastName like ? OR address like ? OR phone like ? OR email like ?";
    List<Object?> whereArgs= [search, search, search, search, search];
    if(gender!=null) {
      where = '($where) AND gender = ?';
      whereArgs.add(gender.toString());
    }
    if(start!=null && end!=null) {
      where = '($where) AND birthDay between ? AND ?';
      whereArgs.add(start.toIso8601String());
      whereArgs.add(end.toIso8601String());
    } else if(start!=null) {
      where = '($where) AND birthDay > ?';
      whereArgs.add(start.toIso8601String());
    } else if(end!=null) {
      where = '($where) AND birthDay < ?';
      whereArgs.add(end.toIso8601String());
    }
    List<Map<String, Object?>> data = await database.query(Taxpayer.TABLE, where: where, whereArgs: whereArgs);
    print(data);
    return List.generate(data.length, (index){
      Map<String, Object?> entity = data[index];
      return Taxpayer.fromJson(entity);
    });
  }

  Future<Taxpayer?> findById(int id) async {
    Database database = await DatabaseAccess().connect();
    List<Map<String, Object?>> data = await database.query(Taxpayer.TABLE, where: "id=?", whereArgs: [id]);
    if(data.isEmpty) return null;
    return Taxpayer.fromJson(data[0]);
  }

  Future<bool> deleteById(int id) async {
    Database database = await DatabaseAccess().connect();
    return await database.delete(Taxpayer.TABLE, where: "id=?", whereArgs: [id]) == 1;
  }

  Future<bool?> updateById(int id, Taxpayer taxpayer) async {
    Database database = await DatabaseAccess().connect();
    Map<String, Object?> map = taxpayer.toJson();
    map.remove("id");
    return await database.update(Taxpayer.TABLE, map, where: "id=?", whereArgs: [id]) == 1;
  }
}