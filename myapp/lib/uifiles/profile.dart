
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue, // Change the background color as needed
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white, // Change the icon color as needed
            ),
          ),
          SizedBox(height: 20),
          Text(
            'xx', // Display the user's name and surname
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Email: $email', // Display the user's email
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            'GenMae', // Display the user's gender
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

