class Doctor {
  String id;
  String doctorsName;
  String doctorsEmail;
  String doctorsPhone;
  String doctorsGender;
  String doctorsSpecialty;
  String doctorsAddress;
  String doctorsCity;
  String doctorsState;
  String doctorsCountry;
  String doctorsHospital;
  String doctorsRating;
  String doctorsAvatar;
  String userType;
  String createdAt;
  String updatedAt;

  Doctor({
    this.id,
    this.doctorsName,
    this.doctorsEmail,
    this.doctorsPhone,
    this.doctorsGender,
    this.doctorsSpecialty,
    this.doctorsAddress,
    this.doctorsCity,
    this.doctorsState,
    this.doctorsCountry,
    this.doctorsHospital,
    this.doctorsRating,
    this.doctorsAvatar,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["id"],
      doctorsName: json["doctors_name"],
      doctorsEmail: json["doctors_email"],
      doctorsPhone: json["doctors_phone"],
      doctorsGender: json["doctors_gender"],
      doctorsSpecialty: json["doctors_specialty"],
      doctorsAddress: json["doctors_address"],
      doctorsCity: json["doctors_city"],
      doctorsState: json["doctors_state"],
      doctorsCountry: json["doctors_country"],
      doctorsHospital: json["doctors_hospital"],
      doctorsRating: json["doctors_rating"],
      doctorsAvatar: json["doctors_avatar"],
      userType: json["user_type"],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctors_name'] = this.doctorsName;
    data['doctors_email'] = this.doctorsEmail;
    data['doctors_phone'] = this.doctorsPhone;
    data['doctors_gender'] = this.doctorsGender;
    data['doctors_specialty'] = this.doctorsSpecialty;
    data['doctors_address'] = this.doctorsAddress;
    data['doctors_city'] = this.doctorsCity;
    data['doctors_state'] = this.doctorsState;
    data['doctors_country'] = this.doctorsCountry;
    data['doctors_hospital'] = this.doctorsHospital;
    data['doctors_rating'] = this.doctorsRating;
    data['doctors_avatar'] = this.doctorsAvatar;
    data['user_type'] = this.userType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
