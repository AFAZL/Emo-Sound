import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class homeofmusiconemotion extends StatelessWidget {
  const homeofmusiconemotion({Key? key}) : super(key: key);

  Future<void> _openCamera(BuildContext context) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      // Handle the captured image, for example, you can display it or process it further
      // Here, we'll just display the image path in a dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Image Captured'),
          content: Text('Image Path: ${image.path}'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music on Emotion'), // Display the title in the app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Music on Emotion', // Display a welcome message
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _openCamera(context), // Open the camera
              child: Text('Open Camera'), // Button to open the camera
            ),
          ],
        ),
      ),
    );
  }
}

class MusicOnEmotionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music on Emotion'), // Display the title in the app bar
      ),
      body: Center(
        child: Text('Music recommendations based on emotion will be displayed here.'), // Placeholder text
      ),
    );
  }
}
