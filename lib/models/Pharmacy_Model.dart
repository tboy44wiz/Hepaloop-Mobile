class Pharmacy {
  String id;
  String pharmacyName;
  String pharmacyEmail;
  String pharmacyPhone;
  String pharmacyAddress;
  String pharmacyCity;
  String pharmacyState;
  String pharmacyCountry;
  String pharmacyLogo;
  String userType;
  String createdAt;
  String updatedAt;

  Pharmacy({
    this.id,
    this.pharmacyName,
    this.pharmacyEmail,
    this.pharmacyPhone,
    this.pharmacyAddress,
    this.pharmacyCity,
    this.pharmacyState,
    this.pharmacyCountry,
    this.pharmacyLogo,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  Pharmacy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyName = json['pharmacy_name'];
    pharmacyEmail = json['pharmacy_email'];
    pharmacyPhone = json['pharmacy_phone'];
    pharmacyAddress = json['pharmacy_address'];
    pharmacyCity = json['pharmacy_city'];
    pharmacyState = json['pharmacy_state'];
    pharmacyCountry = json['pharmacy_country'];
    pharmacyLogo = json['pharmacy_logo'];
    userType = json['user_type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pharmacy_name'] = this.pharmacyName;
    data['pharmacy_email'] = this.pharmacyEmail;
    data['pharmacy_phone'] = this.pharmacyPhone;
    data['pharmacy_address'] = this.pharmacyAddress;
    data['pharmacy_city'] = this.pharmacyCity;
    data['pharmacy_state'] = this.pharmacyState;
    data['pharmacy_country'] = this.pharmacyCountry;
    data['pharmacy_logo'] = this.pharmacyLogo;
    data['user_type'] = this.userType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
