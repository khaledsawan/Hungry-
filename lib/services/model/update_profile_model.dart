class UpdateProfileModel {

  String f_name;
  int phone;
  String email;

  UpdateProfileModel(
      {required this.phone,

      required this.email,
      required this.f_name});

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> json = Map<String, dynamic>();

    json['f_name'] = f_name;
    json['email'] = email;
    json['phone'] = phone;
    return json;
  }
}
