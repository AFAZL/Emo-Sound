import 'package:flutter/material.dart';
import 'package:myapp/services/CRUD.dart';

class ProfilePage extends StatelessWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  Widget build(BuildContext context) {
    print('Email in ProfilePage: $email'); 
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: readUserByName("User", email),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> userData = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name: ${userData['Name']}'),
                  Text('Surname: ${userData['Surname']}'),
                  Text('Email: ${userData['Email']}'),
                  Text('Date of Birth: ${userData['DOB'] ?? 'N/A'}'),
                  Text('Gender: ${userData['Gender']}'),
                  // Add more fields as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
