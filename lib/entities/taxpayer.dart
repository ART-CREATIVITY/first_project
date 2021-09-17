class Taxpayer {

  String? firstName;
  String? lastName;
  Gender? gender;
  DateTime? birthDay;
  String? phone;
  String? email;
  String? address;
  String? identifyPicture;
  bool? bornAround;

  Taxpayer(
      {this.firstName,
      this.lastName,
      this.gender,
      this.birthDay,
      this.phone,
      this.email,
      this.address,
      this.identifyPicture,
      this.bornAround});
}

enum Gender {MALE, FEMALE, OTHER}