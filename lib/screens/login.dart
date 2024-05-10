import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_management/screens/signup.dart';

import 'home.dart';


class LoginScreen extends StatelessWidget {

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final String apiUrl = 'http://10.10.41.30:3001/login';

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userIdController.text,
        'password': passwordController.text,
      }),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final jwtToken = jsonResponse['token'];
      print('token : $jwtToken');// Extract JWT token from response
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen(jwtToken: jwtToken,userId: userIdController.text,)), // Pass token to Homescreen
      );
    } else {
      // Login failed, show error message
      print('Login failed. Error: ${response.statusCode}');
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
       child:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Log in to your account✨',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary
              )),
              Text('Welcome back! Please enter your details.',
                  style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.primary
                  )),
              SizedBox(height: 16),
              Text('User ID'),
              TextField(
                controller: userIdController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                   hintText: 'Enter your User ID',
                prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(height: 16),
              Text('Password'),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot Password?')
                ],
              ),SizedBox(height: 20),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                     minimumSize: const Size.fromHeight(50),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(0), // Set border radius to 0
                   ),
                     backgroundColor: Theme.of(context).colorScheme.primary
                 ),
                  onPressed: (){
                    loginUser(context);
                  },
                  child: Text('Log In',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary
              ),)),
              Center(child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (ctx)=>SignupScreen()));
                  },
                  child: Text ('Don’t have an account? Sign Up'))),
            ],
          ),
      ),
    ),
    ),
    );
  }
}
