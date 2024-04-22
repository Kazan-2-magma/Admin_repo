import 'dart:convert';

import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:http/http.dart' as http;


const String API_KEY = "cb9582f34af59eefdea1b8ab279ff153-1930d364-2188-4027-b974-6f082c29e382";
const url = "https://6glw98.api.infobip.com";
const endPoint = "/sms/2/text/advanced";

Future<http.Response?> fetchData()async{
  try{
    final response = await http.post(
      Uri.parse("$url:$endPoint"),
      headers: {'Authorization': 'Bearer $API_KEY'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
     return jsonData;
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }catch(e){
    print(e.toString());
  }
}