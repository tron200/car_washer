import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class request_helper {

  Future<http.Response> requestPost(Uri uri, Map<String,String> header, Map<String,dynamic> body) async{
    return await http.post(uri, headers:header, body: jsonEncode(body));
  }

}