import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:learn/ui/login_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthencationPage()
    );
  }

  Future<String> getResponse() async {
    try{
    final response = await http.get(Uri.parse("http://10.0.2.2:8000/getname"));
    final body = jsonDecode(response.body);
    return body['message'];
    }catch(err){
      return err.toString();
    }
  }
}
