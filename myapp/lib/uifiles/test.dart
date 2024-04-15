import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String? downloadURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            SizedBox(height: 16.0),
            IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

                if (file == null) return;

                String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');
                Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

                try {
                  // Upload the file to Firebase Storage
                  await referenceImageToUpload.putFile(File(file.path));

                  // Get the download URL of the uploaded file
                  String url = await referenceImageToUpload.getDownloadURL();

                  setState(() {
                    downloadURL = url;
                  });

                  // Do something with the download URL, such as displaying the image or storing it in a database
                  print('Download URL: $downloadURL');
                } catch (error) {
                  // Handle any errors that occur during the upload process
                  print('Error uploading image: $error');
                }
              },
              icon: Icon(Icons.camera),
            ),
            SizedBox(height: 16.0),
            if (downloadURL != null)
              Image.network(
                downloadURL!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}

