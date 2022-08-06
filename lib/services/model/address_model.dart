import 'package:get/get.dart';
class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel({id, required addressType, contactPersonName, contactPersonNumber, address, latitude,
      longitude}) {
    this._id = id;
    this._addressType = addressType;
    this._contactPersonName = contactPersonName;
    this._contactPersonNumber = contactPersonNumber;
    this._address = address;
    this._latitude = latitude;
    this._longitude = longitude;
  }

String get address=>_address;
String get addressType=>_addressType;
String? get contactPersonName=>_contactPersonName;
String? get contactPersonNumber=>_contactPersonNumber;
String get latitude=>_latitude;
String get longitude=>_longitude;

  AddressModel.fromjson(Map<String,dynamic> json){
    _id=json["id"];
    _addressType=json["addressType"];
    _contactPersonName=json["contactPersonName"];
    _contactPersonNumber=json["contactPersonNumber"];
    _address=json["address"];
    _latitude=json["latitude"];
    _longitude=json["longitude"];
  }

  Map toJson() => {
    'addressType': _addressType,
    'id': _id,
    'contact_person_name': _contactPersonName,
    'contact_person_number': _contactPersonNumber,
    'latitude': _latitude,
    'longitude': _longitude,
    'address': _address
  };

  AddressModel.tojson(){
    Map<String,dynamic> json={};
    json["id"]=_id;
    json["addressType"]=_addressType;
    json["contact_person_name"]=_contactPersonName;
    json["contact_person_number"]=_contactPersonNumber;
    json["address"]=_address;
    json["latitude"]=_latitude;
    json["longitude"]=_longitude;

  }

}
