import 'package:flutter/material.dart';
import 'package:myapp/services/CRUD.dart';
import 'package:intl/intl.dart';

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
            // Convert timestamp to DateTime object
            DateTime? dob = userData['DOB']?.toDate();
            // Format DateTime object as a string
            String formattedDob = dob != null ? DateFormat('yyyy-MM-dd').format(dob) : 'N/A';

            return SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/default_image.png'), // Placeholder image URL
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${userData['Name']} ${userData['Surname']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Email: ${userData['Email']}'),
                  Text('Date of Birth: $formattedDob'), // Display formatted date of birth
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
