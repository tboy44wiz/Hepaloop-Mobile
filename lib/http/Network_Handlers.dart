import 'dart:convert';

import 'package:hepaloop/routes/api_routes/API_Route_Names.dart';
import 'package:http/http.dart';

class NetworkHandler {
  var _headers = {
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
