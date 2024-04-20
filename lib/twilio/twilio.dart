import 'dart:convert';

import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:http/http.dart' as http;


// Remove * men accountSid
const String accountSid = "*ACa90769daceea03320adb41aa02a069f5";
const String authToken = "892923217635df726fc7492d8e82624c";
const String twilioNumber = "+12055518171";

const uri = 'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';





final TwilioFlutter twilio = TwilioFlutter(
    accountSid: accountSid,
    authToken: authToken,
    twilioNumber: twilioNumber
);

Future<http.Response> sendMessage(String message,String toNumber)async{
   final response = await http.post(
      Uri.parse(uri),
      headers: <String,String>{
         'Content-Type' : "application/x-www-form-urlencoded",
         'Authorization' : "Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}",
      },
      body: <String,String>{
         "Body" : message,
         "To" : toNumber,
         "From" : twilioNumber
      }
   );
   return response;
}