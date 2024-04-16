import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class emojibased extends StatefulWidget {
  const emojibased({Key? key}) : super(key: key);

  @override
  _emojibasedState createState() => _emojibasedState();
}

class _emojibasedState extends State<emojibased> {
  String? downloadURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242d5c),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF242d5c)),
        backgroundColor: Color(0xFF51cffa),
        title: Text('Moods'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  EmojiCard(
                    title: "Angry",
                    imagePath: "assets/images/angry.png", // You can replace this with your actual image path
                  ),
                  EmojiCard(
                    title: "Happy",
                    imagePath: "assets/images/happy.png",
                  ),
                  EmojiCard(
                    title: "Sad",
                    imagePath: "assets/images/sad.png",
                  ),
                  EmojiCard(
                    title: "Excited",
                    imagePath: "assets/images/Excited.png",
                  ),
                  EmojiCard(
                    title: "Fear",
                    imagePath: "assets/images/fear.png",
                  ),
                  EmojiCard(
                    title: "Love",
                    imagePath: "assets/images/Love.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmojiCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const EmojiCard({
    required this.title,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
