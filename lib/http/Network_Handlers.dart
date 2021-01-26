import 'dart:convert';

import 'package:hepaloop/routes/api_routes/API_Route_Names.dart';
import 'package:http/http.dart';

class NetworkHandler {
  static const _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // 'Authorization': _token,
  };

  // Welcome Route.
  Future<Response> welcomePage() async {
    return await get('http://10.0.2.2:5000');
  }

  // SignUp a User.
  Future<Response> signUpUser(String url, Map<String, String> body) async {
    var _fullURL = baseURL + url;
    print(_fullURL);

    return await post(
      _fullURL,
      headers: _headers,
      body: jsonEncode(body),
    );
  }

  //  Login a User.
  Future<Response> loginUser(String url, Map<String, String> body) async {
    var _fullURL = baseURL + url;

    return await post(
      _fullURL,
      headers: _headers,
      body: jsonEncode(body),
    );
  }

  //  Update users avatar.
  Future<StreamedResponse> updateUsersAvatar(
      String url, String filePath, String token) async {
    var _fullURL = '$baseURL$url';
    var request = MultipartRequest(
      'PUT',
      Uri.parse(_fullURL),
    );
    request.files.add(
      await MultipartFile.fromPath(
        'avatar',
        filePath,
      ),
    );
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': token,
    });

    return request.send();
  }

  //  Get CountryStateCity Token.
  Future<String> getCountryStateCityToken() async {
    var fullURL = '$countryStateCityBaseURL$getAccessTokenRoute';

    Response response = await get(
      fullURL,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'api-token': countryStateCityAPI_Token,
        'user-email': userEmail,
      },
    );

    var countryStateCityToken = '';
    if (response.statusCode == 200) {
      var tokenResponseBody = jsonDecode(response.body);
      countryStateCityToken = tokenResponseBody['auth_token'];
      return countryStateCityToken;
    }

    return countryStateCityToken;
  }

  //  Get World Countries.
  Future<Response> getWorldCountries(String url) async {
    var fullURL = '$countryStateCityBaseURL$url';
    String tokenResponse = await getCountryStateCityToken();

    return await get(
      fullURL,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenResponse',
      },
    );
  }

  //  Get States.
  Future<Response> getStates(String url, String selectedCountry) async {
    var fullURL = '$countryStateCityBaseURL$url$selectedCountry';
    print(fullURL);

    String tokenResponse = await getCountryStateCityToken();

    return await get(
      fullURL,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenResponse',
      },
    );
  }

  //  Get Cities.
  Future<Response> getCities(String url, String selectedState) async {
    var fullURL = '$countryStateCityBaseURL$url$selectedState';

    String tokenResponse = await getCountryStateCityToken();

    return await get(
      fullURL,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenResponse',
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  ////////////////////////////   DOCTOR API CALLS   ////////////////////////////
  Future<Response> updateDoctor(
      String url, String id, Map<String, dynamic> body, String token) async {
    var _fullURL = '$baseURL$url/$id';

    return await put(
      _fullURL,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode(body),
    );
  }
}
