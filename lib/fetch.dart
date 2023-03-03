import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

Future<ApiResponse> fetchData() async {
  final response = await http.get(Uri.parse('http://ec2-3-137-201-63.us-east-2.compute.amazonaws.com/api/nafisa/getdata'));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
