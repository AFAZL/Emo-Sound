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
        title: Text('Profile', style: TextStyle(color: Color(0xFF242d5c))), 
        backgroundColor: Color(0xFF51cffa),
      ),
      backgroundColor: Color(0xFF242d5c),
      body: FutureBuilder<Map<String, dynamic>>(
        future: readUserByName("User", email),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
          } else {
            Map<String, dynamic> userData = snapshot.data!;
           
            DateTime? dob = userData['DOB']?.toDate();
           
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
                            color: Colors.white, 
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildFieldWithBorder('Email: ${userData['Email']}'),
                  _buildFieldWithBorder('Date of Birth: $formattedDob'),
                  _buildFieldWithBorder('Gender: ${userData['Gender']}'),
                ],
              ),
            );
          }
        },
      ),
    );
  } 

  Widget _buildFieldWithBorder(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white), // Set border color to white
        borderRadius: BorderRadius.circular(8.0), // Set border radius
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 30, color: Colors.white), // Set text size and color
      ),
    );
  }
}
