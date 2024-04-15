import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class MusicAdder extends StatefulWidget {
  const MusicAdder({Key? key}) : super(key: key);

  @override
  _MusicAdderState createState() => _MusicAdderState();
}

class _MusicAdderState extends State<MusicAdder> {
  Uint8List? _selectedMusicBytes;
  Uint8List? _selectedCoverBytes;

  Future<void> _uploadFiles() async {
    try {
      FilePickerResult? musicResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3'],
      );

      FilePickerResult? coverResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (musicResult != null && coverResult != null) {
        setState(() {
          _selectedMusicBytes = musicResult.files.single.bytes;
          _selectedCoverBytes = coverResult.files.single.bytes;
        });

        final Reference musicStorageRef = FirebaseStorage.instance
            .ref()
            .child('music/${DateTime.now().millisecondsSinceEpoch}.mp3');

        final Reference coverStorageRef = FirebaseStorage.instance
            .ref()
            .child('covers/${DateTime.now().millisecondsSinceEpoch}.jpg');

        await musicStorageRef.putData(_selectedMusicBytes!);
        await coverStorageRef.putData(_selectedCoverBytes!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Files Uploaded Successfully'),
          ),
        );
      }
    } catch (error) {
      print('Error uploading files: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading files'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Adder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedMusicBytes != null
                ? Text('Music File Selected')
                : Text('No music file selected'),
            SizedBox(height: 20),
            _selectedCoverBytes != null
                ? Image.memory(_selectedCoverBytes!)
                : Text('No cover image selected'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadFiles,
        tooltip: 'Upload Files',
        child: Icon(Icons.file_upload),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MusicAdder(key: GlobalKey()),
  ));
}
