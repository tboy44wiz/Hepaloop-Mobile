class Hospital {
  String id;
  String hospitalsName;
  String hospitalsEmail;
  String hospitalsPhone;
  String hospitalsAddress;
  String hospitalsCity;
  String hospitalsState;
  String hospitalsCountry;
  String hospitalsLogo;
  String userType;
  String createdAt;
  String updatedAt;

  Hospital({
    this.id,
    this.hospitalsName,
    this.hospitalsEmail,
    this.hospitalsPhone,
    this.hospitalsAddress,
    this.hospitalsCity,
    this.hospitalsState,
    this.hospitalsCountry,
    this.hospitalsLogo,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalsName = json['hospitals_name'];
    hospitalsEmail = json['hospitals_email'];
    hospitalsPhone = json['hospitals_phone'];
    hospitalsAddress = json['hospitals_address'];
    hospitalsCity = json['hospitals_city'];
    hospitalsState = json['hospitals_state'];
    hospitalsCountry = json['hospitals_country'];
    hospitalsLogo = json['hospitals_logo'];
    userType = json['user_type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospitals_name'] = this.hospitalsName;
    data['hospitals_email'] = this.hospitalsEmail;
    data['hospitals_phone'] = this.hospitalsPhone;
    data['hospitals_address'] = this.hospitalsAddress;
    data['hospitals_city'] = this.hospitalsCity;
    data['hospitals_state'] = this.hospitalsState;
    data['hospitals_country'] = this.hospitalsCountry;
    data['hospitals_logo'] = this.hospitalsLogo;
    data['user_type'] = this.userType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
