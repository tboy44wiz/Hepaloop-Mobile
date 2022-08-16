/*
* Base URL.
*/
// const String baseURL = 'https://hepaloop-api.herokuapp.com/api/v1';
// const String baseURL = 'http://10.0.2.2:5000/api/v1'; //  Emulator
// const String baseURL = 'http://192.168.0.143:5000/api/v1'; // AITech WiFi
const String baseURL = 'http://192.168.1.36:5000/api/v1'; // AITech Fibre
// const String baseURL = 'http://192.168.43.244:5000/api/v1'; // Phone WiFi

/*
* Base URL for Country, State, City API.
*/
const countryStateCityBaseURL = 'https://www.universal-tutorial.com/api';
const countryStateCityAPIToken = '85UUCHe-uDXQxD48YI60umbGtU3vmTvXTf_lBysFbSdKxK7aW-PjPiarlNhUNmTum7M';
const userEmail = 'tosolife@yahoo.com';
const getAccessTokenRoute = '/getaccesstoken';
const getCountriesRoute = '/countries';
const getStatesRoute = '/states/';
const getCitiesRoute = '/cities/';

/*
* Users API Routes.
*/
const String signUpUserRoute = '/users/signup';
const String loginUserRoute = '/users/login';
const String getSingleUserRoute = '/users/single_user';
const String updateUserPictureRoute = '/users/upload_user_picture';



/*
* Doctors API Routes.
*/
const String createDoctorRoute = '/doctors/create_doctor';
// const String getAllDoctorsRoute = '/doctors/all_doctors';
// const String getSingleDoctorRoute = '/doctors/single_doctor';
// const String updateDoctorRoute = '/doctors/update_doctor';
// const String deleteDoctorRoute = '/doctors/delete_doctor';
// const String updateDoctorAvatarRoute = '/doctors/update_avatar';
const String getAllNearByDoctorsRoute = '/doctors/all_nearBy_doctors';

/*
* Individuals API Routes.
* */
const String createIndividualRoute = '/individuals/create_individual';
// const String getAllIndividualsRoute = '/individuals/all_individuals';
// const String getSingleIndividualRoute = '/individuals/single_individual';
// const String updateIndividualRoute = '/individuals/update_individual';
// const String deleteIndividualRoute = '/individuals/delete_individual';
// const String updateIndividualAvatarRoute = '/individuals/update_avatar';

//  Hospital API Routes.
// const String loginHospitalRoute = '/hospitals/login';
// const String signUpHospitalRoute = '/hospitals/signup';
// const String createHospitalRoute = '/hospitals/create_hospital';
// const String getAllHospitalRoute = '/hospitals/all_hospitals';
// const String getSingleHospitalRoute = '/hospitals/single_hospital';
// const String updateHospitalRoute = '/hospitals/update_hospital';
// const String deleteHospitalRoute = '/hospitals/delete_hospital';
// const String updateHospitalAvatarRoute = '/hospitals/update_avatar';

//  Pharmacy API Routes.
// const String loginPharmacyRoute = '/pharmacy/login';
// const String signUpPharmacyRoute = '/pharmacy/signup';
// const String createPharmacyRoute = '/pharmacy/create_pharmacy';
// const String getAllPharmacyRoute = '/pharmacy/all_pharmacy';
// const String getSinglePharmacyRoute = '/pharmacy/single_pharmacy';
// const String updatePharmacyRoute = '/pharmacy/update_pharmacy';
// const String deletePharmacyRoute = '/pharmacy/delete_pharmacy';
// const String updatePharmacyAvatarRoute = '/pharmacy/update_avatar';

//  Consultation API Routes.
const String createConsultationRequestRoute = '/consultations/create_consultation';
// const String getAllPendingConsultationRoute = '/consultations/all_pending_consultation';
const String getSingleConsultationRoute = '/consultations/single_consultation';
const String updateConsultationRoute = '/consultations/update_consultation';
// const String deleteConsultationRoute = '/consultations/delete_consultation';

//  Notification API Routes.
const String getAllUsersNotificationsRoute = '/notifications/all_notifications';
const String updateSingleNotificationRoute = '/notifications/update_notification';
const String deleteSingleNotificationRoute = '/notifications/delete_notification';

//  Doctor and Patient Relationship API Routes.
const String getAllDoctorPatientsRoute = '/doctor_patient/all_doctor_patients';
const String getAllIndividualDoctorsRoute = '/doctor_patient/all_individual_doctors';