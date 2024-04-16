import 'package:flutter/material.dart';
import 'package:myapp/uifiles/MusicBasedOnEmoji/MusicOnEmoji.dart';

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
                  EmojiButton(
                    title: "Angry",
                    imagePath: "assets/images/angry.png",
                    mood: "Angry",
                  ),
                  EmojiButton(
                    title: "Happy",
                    imagePath: "assets/images/happy.png",
                    mood: "Happy",
                  ),
                  EmojiButton(
                    title: "Sad",
                    imagePath: "assets/images/sad.png",
                    mood: "Sad",
                  ),
                  EmojiButton(
                    title: "Excited",
                    imagePath: "assets/images/Excited.png",
                    mood: "Excited",
                  ),
                  EmojiButton(
                    title: "Fear",
                    imagePath: "assets/images/Fear.png",
                    mood: "Fear",
                  ),
                  EmojiButton(
                    title: "Love",
                    imagePath: "assets/images/Love.png",
                    mood: "Love",
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

class EmojiButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final String mood;

  const EmojiButton({
    required this.title,
    required this.imagePath,
    required this.mood,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MusicOnEmoji1(mood: '$mood')),
          );
        },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      ),
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
