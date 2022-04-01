import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class request_helper {
  Map<String, String> header2 = {'Content-Type': 'application/json; charset=UTF-8'};
  Future<http.Response> requestPost(Uri uri, Map<String,dynamic> body,[Map<String, String>? header] ) async{

    return await http.post(uri, headers:header==null?header2:header, body: jsonEncode(body),encoding: Encoding.getByName("utf-8")
    );
  }

  Future<http.Response> requestGet(Uri uri,Map<String, String> header) async{
    return await http.get(uri, headers:header);
  }

}