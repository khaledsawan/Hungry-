class UserProfileModel {
  int? id;
  String? fName;
  int? phone;
  String? email;
  int? status;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? orderCount;
  int? memberSinceDays;

  UserProfileModel(
      {this.id,
        this.fName,
        this.phone,
        this.email,
        this.status,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.orderCount,
        this.memberSinceDays});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderCount = json['order_count'];
    memberSinceDays = json['member_since_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_count'] = this.orderCount;
    data['member_since_days'] = this.memberSinceDays;
    return data;
  }
}