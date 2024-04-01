import 'dart:html';

import 'package:flutter/material.dart';
import 'package:myapp/uifiles/profile.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments;
    print("Home $email");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 79, 39, 181),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print('Email before navigation: $email');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(email: '$email'))
                );
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your navigation logic here
              },
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
