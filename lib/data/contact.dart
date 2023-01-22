import 'dart:io';

class Contact {
  int? id;
  String? name;
  String? email;
  String? phonenumber;
  String? address;
  bool isfavorite;
  File? contactImage;

  Contact(
      {this.name,
      this.email,
      this.phonenumber,
      this.address,
      this.isfavorite = false,
      this.contactImage});

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
      'isfavorite': isfavorite,
      'address': address,
      'contactImagepath': contactImage?.path,
    };
  }

  static Contact frommap(Map<String, dynamic> map) {
    return Contact(
        name: map['name'],
        email: map['email'],
        phonenumber: map['phonenumber'],
        isfavorite: map['isfavorite'],
        address: map['address'],
        contactImage: map['contactImagepath'] != null
            ? File(map['contactImagepath'])
            : null);
  }
}
