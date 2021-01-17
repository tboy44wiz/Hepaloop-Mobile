class Patient {
  String id;
  String patientsName;
  String patientsEmail;
  String patientsPhone;
  String patientsGender;
  String patientsDOB;
  int patientsAge;
  String patientsAddress;
  String patientsCity;
  String patientsState;
  String patientsCountry;
  String patientsHeight;
  String patientsWeight;
  String patientsAvatar;
  String purposeForTreatment;
  String userType;
  String createdAt;
  String updatedAt;

  Patient({
    this.id,
    this.patientsName,
    this.patientsEmail,
    this.patientsPhone,
    this.patientsGender,
    this.patientsDOB,
    this.patientsAge,
    this.patientsAddress,
    this.patientsCity,
    this.patientsState,
    this.patientsCountry,
    this.patientsHeight,
    this.patientsWeight,
    this.patientsAvatar,
    this.purposeForTreatment,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientsName = json['patients_name'];
    patientsEmail = json['patients_email'];
    patientsPhone = json['patients_phone'];
    patientsGender = json['patients_gender'];
    patientsDOB = json['patients_DOB'];
    patientsAge = json['patients_age'];
    patientsAddress = json['patients_address'];
    patientsCity = json['patients_city'];
    patientsState = json['patients_state'];
    patientsCountry = json['patients_country'];
    patientsHeight = json['patients_height'];
    patientsWeight = json['patients_weight'];
    patientsAvatar = json['patients_avatar'];
    purposeForTreatment = json['purpose_for_treatment'];
    userType = json['user_type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patients_name'] = this.patientsName;
    data['patients_email'] = this.patientsEmail;
    data['patients_phone'] = this.patientsPhone;
    data['patients_gender'] = this.patientsGender;
    data['patients_DOB'] = this.patientsDOB;
    data['patients_age'] = this.patientsAge;
    data['patients_address'] = this.patientsAddress;
    data['patients_city'] = this.patientsCity;
    data['patients_state'] = this.patientsState;
    data['patients_country'] = this.patientsCountry;
    data['patients_height'] = this.patientsHeight;
    data['patients_weight'] = this.patientsWeight;
    data['patients_avatar'] = this.patientsAvatar;
    data['purpose_for_treatment'] = this.purposeForTreatment;
    data['user_type'] = this.userType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
