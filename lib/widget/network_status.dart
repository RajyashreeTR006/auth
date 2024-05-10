import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import '../screens/login.dart';

class NetworkStatusWidget extends StatefulWidget {
  @override
  _NetworkStatusWidgetState createState() => _NetworkStatusWidgetState();
}

class _NetworkStatusWidgetState extends State<NetworkStatusWidget> {
  @override
  void initState() {
    super.initState();
    _checkNetworkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoginScreen(),
      ),
    );
  }

  Future<void> _checkNetworkStatus() async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNetworkUnavailableSnackbar();
    } else {
      // Connection available, do nothing
    }

    // Replace 'userId' and 'status' with actual values
    String userId = 'userId';
    String status = 'online'; // or 'offline'

    updateUserStatus(userId, status);
  }

  void _showNetworkUnavailableSnackbar() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network Unavailable'),
          duration: Duration(seconds: 6),
        ),
      );
    });
  }


  void updateUserStatus(String userId, String status) async {
    final String apiUrl = 'YOUR_API_ENDPOINT'; // Replace with your API endpoint URL

    try {
      // Send a POST request with user ID and status
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        print('User status updated successfully');
      } else {
        print('Failed to update user status. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating user status: $error');
    }
  }
}
