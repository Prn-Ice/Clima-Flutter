// The networking class takes in the url for the api get request
// and returns the api response using the getData function

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utilities/constants.dart';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

//  Try to get data from url during specified duration
  Future getData() async {
    http.Response response =
        await http.get(url).timeout(kHttpRequestTimeOut).catchError((e) {
      print(e);
    });

//    if the request got through
    if (response != null) {
      //    if the request was successful
      if (response.statusCode == 200) {
//      store the response as a string
        String data = response.body;

//      return the decoded json response
        return jsonDecode(data);
      } else
        print(response.statusCode);
      print(response.body);
    } else {
      print('Network request unsuccessful');
//      return null;
    }
  }
}
