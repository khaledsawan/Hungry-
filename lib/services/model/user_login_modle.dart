class UserLoginModel {
  Data? data;

  UserLoginModel({this.data});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? mobile;
  String? gender;
  String? age;
  String? city;
  String? universityCollege;
  String? academicYear;
  String? universityCard;
  Null? houseId;
  String? description;
  int? points;
  String? createdAt;
  String? updatedAt;
  String? role;
  String? token;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.userName,
        this.email,
        this.mobile,
        this.gender,
        this.age,
        this.city,
        this.universityCollege,
        this.academicYear,
        this.universityCard,
        this.houseId,
        this.description,
        this.points,
        this.createdAt,
        this.updatedAt,
        this.role,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['user_name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    age = json['age'];
    city = json['city'];
    universityCollege = json['university_college'];
    academicYear = json['academic_year'];
    universityCard = json['university_card'];
    houseId = json['house_id'];
    description = json['description'];
    points = json['points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['city'] = this.city;
    data['university_college'] = this.universityCollege;
    data['academic_year'] = this.academicYear;
    data['university_card'] = this.universityCard;
    data['house_id'] = this.houseId;
    data['description'] = this.description;
    data['points'] = this.points;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    data['token'] = this.token;
    return data;
  }
}