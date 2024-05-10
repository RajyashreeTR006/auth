import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class Homescreen extends StatelessWidget {

  final String jwtToken;
  final String userId;


  const Homescreen({super.key, required this.jwtToken, required this.userId});

  void logout(BuildContext context, String userId) async {
    // Make an HTTP POST request to logout endpoint
    final response = await http.post(
      Uri.parse('http://10.10.41.30:3001/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'userId': userId, // Include the userId in the request body
      }),
    );


    if (response.statusCode == 200) {
      // If the server responds with success, navigate to the login screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> LoginScreen()));
    } else {
      // If there's an error, display an error message
      print('Logout failed. Error: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed. Please try again later.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  // Call the logout function when the user presses the logout button
                  logout(context, userId);
                },
              ),
            ],
          ),
      body: Center(
        child: Text('Home'),
    )
        )
    );
  }
}
