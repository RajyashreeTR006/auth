import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {

  final String apiUrl = 'http://10.10.41.30:3001/postData'; // Update with your backend server URL

  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordrController = TextEditingController();

  Future<void> postData() async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; '
            'charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobileNumber': mobileNumberController.text,
        'userId': userIdController.text,
        'userName': nameController.text,
        'password': passwordrController.text
      }),
    );

    if (response.statusCode == 200) {
      print('Data inserted successfully');
    } else {
      print('Failed to insert data. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create an account✨',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary
                        )),
                    Text('Welcome! Please enter your details.',
                        style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.primary
                        )),
                    SizedBox(height: 16),
                    Text('Name'),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Enter your name',
                        prefixIcon: Icon(Icons.person),),
                    ),
                    SizedBox(height: 16),
                    Text('User ID'),
                    TextField(
                      controller: userIdController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Enter your User ID',
                        prefixIcon: Icon(Icons.person),),
                    ),
                    SizedBox(height: 16),
                    Text('Mobile Number'),
                    TextField(
                      controller: mobileNumberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Enter your mobile number',
                        prefixIcon: Icon(Icons.call),),
                    ),
                    SizedBox(height: 16),
                    Text('Password'),
                    TextField(
                      controller: passwordrController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0), // Set border radius to 0
                            ),
                            backgroundColor: Theme.of(context).colorScheme.primary
                        ),
                        onPressed: () {
                          postData();
                          // mobileNumberController.clear();
                          // userIdController.clear();
                        }
                        , child: Text('Signup',
                           style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary
                      ),)),
                    Center(child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text('Already have an account? Login'))),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
