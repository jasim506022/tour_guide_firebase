class ProfileModel {
  String? email;
  String? name;
  String? phone;
  String? status;
  String? uid;
  String? gender;
  ProfileModel(
      {this.gender, this.email, this.name, this.phone, this.status, this.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'uid': uid,
      "status": status,
      "phone": phone,
      "gender": gender
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      email: map['email'],
      gender: map['gender'],
      name: map['name'],
      phone: map['phone'],
      status: map['status'],
      uid: map['uid'],
    );
  }
}
