import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    print(arguments);
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
                Navigator.pushReplacementNamed(
                  context,
                  '/profile',
                  arguments: arguments,
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
