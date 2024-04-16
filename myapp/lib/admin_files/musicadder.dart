import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MusicAdder extends StatefulWidget {
  const MusicAdder({Key? key}) : super(key: key);

  @override
  _MusicAdderState createState() => _MusicAdderState();
}

class _MusicAdderState extends State<MusicAdder> {
  String _selectedType = 'Angry';
  String _selectedCategory = 'Top Hit';
  String? _imageUrl;
  String? _musicUrl;
  String? _title;
  String? _author;

  final List<String> musicTypes = ['Angry', 'Fear', 'Happy', 'Sad', 'Excited'];
  final List<String> musicCategories = ['Top Hit', 'Trending'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Adder'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
                items: musicTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                items: musicCategories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  _title = value;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  _author = value;
                },
                decoration: InputDecoration(
                  labelText: 'Author',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadMusic,
                child: Text('Upload Music'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Submit Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
        await ref.putFile(file);
        _imageUrl = await ref.getDownloadURL();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image Uploaded: $_imageUrl'),
          ),
        );
      }
    } catch (error) {
      print('Error picking image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image'),
        ),
      );
    }
  }

  Future<void> _uploadMusic() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        String fileName = '${DateTime.now().millisecondsSinceEpoch}.mp3';
        Reference ref = FirebaseStorage.instance.ref().child('music/$fileName');
        await ref.putFile(file);
        _musicUrl = await ref.getDownloadURL();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Music Uploaded: $_musicUrl'),
          ),
        );
      }
    } catch (error) {
      print('Error picking music: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking music'),
        ),
      );
    }
  }

  Future<void> _submitData() async {
    if (_imageUrl != null && _musicUrl != null && _title != null && _author != null) {
      try {
        await FirebaseFirestore.instance.collection('media').add({
          'title': _title,
          'author': _author,
          'type': _selectedType,
          'category': _selectedCategory,
          'imageUrl': _imageUrl,
          'musicUrl': _musicUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data Submitted Successfully'),
          ),
        );
      } catch (error) {
        print('Error submitting data: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting data'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields and upload both image and music before submitting.'),
        ),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: MusicAdder(),
  ));
}
