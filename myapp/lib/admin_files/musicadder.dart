import 'dart:typed_data';
import 'dart:io';
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
  Uint8List? _selectedImageBytes;
  Uint8List? _selectedMusicBytes;
  String _selectedType = 'Angry';
  String _selectedCategory = 'Top Hit';

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
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload Image'),
              ),
              SizedBox(height: 10),
              if (_selectedImageBytes != null)
                ElevatedButton(
                  onPressed: _getImageUrl,
                  child: Text('Get Image URL'),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadMusic,
                child: Text('Upload Music'),
              ),
              SizedBox(height: 10),
              if (_selectedMusicBytes != null)
                ElevatedButton(
                  onPressed: _getMusicUrl,
                  child: Text('Get Music URL'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _uploadImage();
          _uploadMusic();
        },
        tooltip: 'Upload',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _uploadImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        final filePath = result.files.single.path;
        if (filePath != null) {
          setState(() {
            _selectedImageBytes = File(filePath).readAsBytesSync();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Image Selected'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: Failed to retrieve image file path.'),
            ),
          );
        }
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

  Future<void> _getImageUrl() async {
    try {
      if (_selectedImageBytes != null) {
        final Reference imageRef = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await imageRef.putData(_selectedImageBytes!);
        String imageUrl = await imageRef.getDownloadURL();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image URL: $imageUrl'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select an image first.'),
          ),
        );
      }
    } catch (error) {
      print('Error getting image URL: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting image URL'),
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
        final filePath = result.files.single.path;
        if (filePath != null) {
          setState(() {
            _selectedMusicBytes = File(filePath).readAsBytesSync();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Music Selected'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: Failed to retrieve music file path.'),
            ),
          );
        }
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


  Future<void> _getMusicUrl() async {
    try {
      if (_selectedMusicBytes != null) {
        final Reference musicRef = FirebaseStorage.instance
            .ref()
            .child('music/${DateTime.now().millisecondsSinceEpoch}.mp3');
        await musicRef.putData(_selectedMusicBytes!);
        String musicUrl = await musicRef.getDownloadURL();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Music URL: $musicUrl'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select music first.'),
          ),
        );
      }
    } catch (error) {
      print('Error getting music URL: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting music URL'),
        ),
      );
    }
  }

  Future<void> _submitData() async {
    try {
      print('_selectedImageBytes: $_selectedImageBytes');
      print('_selectedMusicBytes: $_selectedMusicBytes');
      print('_selectedType: $_selectedType');
      print('_selectedCategory: $_selectedCategory');

      if (_selectedImageBytes != null &&
          _selectedMusicBytes != null &&
          _selectedType.isNotEmpty &&
          _selectedCategory.isNotEmpty) {
        // Upload image
        final Reference imageRef = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await imageRef.putData(_selectedImageBytes!);
        String imageUrl = await imageRef.getDownloadURL();

        // Upload music
        final Reference musicRef = FirebaseStorage.instance
            .ref()
            .child('music/${DateTime.now().millisecondsSinceEpoch}.mp3');
        await musicRef.putData(_selectedMusicBytes!);
        String musicUrl = await musicRef.getDownloadURL();

        // Save data to Firestore
        await FirebaseFirestore.instance.collection('media').add({
          'type': _selectedType,
          'category': _selectedCategory,
          'imageUrl': imageUrl,
          'musicUrl': musicUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data Submitted Successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select both image and music and fill in type and category.'),
          ),
        );
      }
    } catch (error) {
      print('Error submitting data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting data'),
        ),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: MusicAdder(key: GlobalKey()),
  ));
}
