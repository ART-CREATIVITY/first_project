import 'package:json_annotation/json_annotation.dart';

part 'taxpayer.g.dart';

@JsonSerializable()
class Taxpayer {

  int ?id;
  String? firstName;
  String? lastName;
  Gender? gender;
  DateTime? birthDay;
  String? phone;
  String? email;
  String? address;
  String? identifyPicture;
  bool? bornAround;
  String? serverId;

  static const String TABLE = "Taxpayer";

  Taxpayer(
      {
        this.id,
        this.firstName,
      this.lastName,
      this.gender,
      this.birthDay,
      this.phone,
      this.email,
      this.address,
      this.identifyPicture,
      this.bornAround,
      this.serverId});

  factory Taxpayer.fromJson(Map<String, dynamic> json) => _$TaxpayerFromJson(json);
  Map<String, dynamic> toJson() => _$TaxpayerToJson(this);
  Map<String, dynamic> toRestJson() => _$TaxpayerToRestJson(this);

  @override
  String toString() {
    return 'Taxpayer{id: $id,firstName: $firstName, lastName: $lastName, gender: $gender, birthDay: $birthDay, phone: $phone, email: $email, address: $address, identifyPicture: $identifyPicture, bornAround: $bornAround, serverId: $serverId}';
  }


}

enum Gender {MALE, FEMALE, OTHER}