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

  @override
  String toString() {
    return 'Taxpayer{firstName: $firstName, lastName: $lastName, gender: $gender, birthDay: $birthDay, phone: $phone, email: $email, address: $address, identifyPicture: $identifyPicture, bornAround: $bornAround}';
  }
}

enum Gender {MALE, FEMALE, OTHER}