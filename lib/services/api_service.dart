import 'package:dio/dio.dart';

import '../routes/api_routes/api_route_names.dart';

class APIService {
  static const _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // 'Authorization': _token,
  };


  //  Get CountryStateCity Token.
  static Future<String> getCountryStateCityToken() async {
    String _fullURL = '$countryStateCityBaseURL$getAccessTokenRoute';

    try {
      Response _response = await Dio().get(
        _fullURL,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'api-token': countryStateCityAPIToken,
          'user-email': userEmail,
        }),
      );

      String countryStateCityToken = '';
      if (_response.statusCode == 200) {
        var tokenResponseData = _response.data;
        countryStateCityToken = tokenResponseData['auth_token'];
        return countryStateCityToken;
      }
      return countryStateCityToken;
    } on DioError catch (e) {
      if (e.response != null) {
        return e.message;
      }
      throw Exception(e.response);
    }
  }

  //  Get Countries.
  static Future<Response?> getWorldCountries(String url) async {
    var _fullURL = '$countryStateCityBaseURL$url';
    String tokenResponse = await getCountryStateCityToken();

    try {
      return await Dio().get(
        _fullURL,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenResponse',
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Get States.
  static Future<Response?> getStates(String url, String selectedCountry) async {
    var _fullURL = '$countryStateCityBaseURL$url$selectedCountry';
    String tokenResponse = await getCountryStateCityToken();

    try {
      return await Dio().get(
        _fullURL,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenResponse',
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Get Cities.
  static Future<Response?> getCities(String url, String selectedState) async {
    var _fullURL = '$countryStateCityBaseURL$url$selectedState';
    String tokenResponse = await getCountryStateCityToken();

    try {
      return await Dio().get(
        _fullURL,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenResponse',
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }


  //  SignUp User.
  static Future<Response?> signupUserService(String url, Map<String, dynamic> userSignUpData) async {
    var _fullURL = "$baseURL$url";
    print("URL::: $_fullURL \n $userSignUpData");

    try {
      return await Dio().post(
        _fullURL,
        data: userSignUpData,
        options: Options(headers: _headers),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Login User.
  static Future<Response?> loginUserService(String url, Map<String, dynamic> userLoginData) async {
    var _fullURL = "$baseURL$url";
    print("URL::: $_fullURL \n $userLoginData");

    try {
      return await Dio().post(
        _fullURL,
        data: userLoginData,
        options: Options(headers: _headers),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Get Single User.
  static Future<Response?> getSingleUser(String url, String userId) async {
    var _fullURL = "$baseURL$url/$userId";
    // print("URL::: $_fullURL \n $userId");

    try {
      return await Dio().get(
        _fullURL,
        options: Options(headers: _headers),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }


  /*
  * DOCTOR
  * */
  ///////////////////////////////////////////////////////////////////////////////////////////////////
  //  Create a Doctor
  static Future<Response?> createDoctorService(String url, Map<String, dynamic> doctorData, String token) async {
    var _fullURL = "$baseURL$url";
    // print("URL::: $_fullURL \n $doctorData \n $token");

    try {
      return await Dio().post(
        _fullURL,
        data: doctorData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Get all NearBy Doctors
  static Future<Response?> getAllNearByDoctorsService(String url, String location, String token) async {
    var _fullURL = '$baseURL$url/$location';
    // print("$_fullURL \n $location \n $token");

    try {
      return await Dio().get(
          _fullURL,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': token,
            },
          )
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Get Doctors Patients
  static Future<Response?> getDoctorPatientService(String url, String token) async {
    var _fullURL = '$baseURL$url';
    // print("$_fullURL \n $token");

    try {
      return await Dio().get(
          _fullURL,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': token,
            },
          )
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }


  /*
  * INDIVIDUAL
  * */
  ///////////////////////////////////////////////////////////////////////////////////////////////////
  //  Create a Individual
  static Future<Response?> createIndividualService(String url, Map<String, dynamic> individualData, String token) async {
    var _fullURL = "$baseURL$url";
    // print("URL::: $_fullURL \n $individualData \n $token");

    try {
      return await Dio().post(
        _fullURL,
        data: individualData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }

  //  Get Doctors Patients
  static Future<Response?> getPatientDoctorService(String url, String token) async {
    var _fullURL = '$baseURL$url';
    // print("$_fullURL \n $token");

    try {
      return await Dio().get(
          _fullURL,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': token,
            },
          )
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }


  /*
  * USER PROFILE PICTURE
  * */
  ///////////////////////////////////////////////////////////////////////////////////////////////////
  //  Update User Picture
  static Future<Response?> updateUserPicture(String url, String filePath, String token) async {
    var _fullURL = "$baseURL$url";
    // print("URL::: $_fullURL \n $filePath \n $token");

    try {
      String fileName = filePath.split('/').last;
      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(
            filePath,
            filename: fileName
        ),
      });

      return await Dio().put(
        _fullURL,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.response);
    }
  }



  //////////////////////////////////////////////////////////////////////////////
  /////////////////////////   NOTIFICATIONS API CALLS   ////////////////////////
  static Future<Response?> getAllUsersNotifications(String url, String id, String token) async {
    var _fullURL = '$baseURL$url/$id';
    // print("FULL URL::: $_fullURL \n TOKEN::: $token");

    try {
      return await Dio().get(
        _fullURL,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.message);
    }
  }

  static Future<Response?> updateSingleNotificationService(String url, String id, Map<String, dynamic> notificationData) async {
    var _fullURL = '$baseURL$url/$id';
    // print("FULL URL::: $_fullURL \n DATA::: $notificationData");

    try {
      return await Dio().put(
        _fullURL,
        data: notificationData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.message);
    }
  }

  static Future<Response?> deleteSingleNotification(String url, String id, String token) async {
    var _fullURL = '$baseURL$url/$id';

    try {
      return await Dio().delete(
        _fullURL,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.message);
    }
  }



  //////////////////////////////////////////////////////////////////////////////
  //////////////////////   CONSULTATION REQUEST API CALLS   ////////////////////
  static Future<Response?> createConsultationService(String url, Map<String, dynamic> consultationRequestData, String token) async {
    var _fullURL = '$baseURL$url';
    // print("URL LINK::: $_fullURL \n DATAAA::: $consultationRequestData \n TOKEEEEN::: $token");

    try {
      return await Dio().post(
          _fullURL,
          data: consultationRequestData,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': token,
              }
          )
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.message);
    }
  }

  static Future<Response?> getSingleConsultationService(String url, String id, String token) async {
    var _fullURL = '$baseURL$url/$id';
    // print("URL LINK::: $_fullURL \n ID::: $id \n TOKEEEEN::: $token");

    try {
      return await Dio().get(
          _fullURL,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': token,
              }
          )
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.message);
    }
  }

  static Future<Response?> updateConsultationService(String url, String id, Map<String, dynamic> consultationRequestData, String token) async {
    var _fullURL = '$baseURL$url/$id';
    // print("DDDDDD::: $_fullURL \n $id \n $consultationRequestData \n $token");

    try {
      return await Dio().put(
        _fullURL,
        data: consultationRequestData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response;
      }
      throw Exception(e.message);
    }
  }

}