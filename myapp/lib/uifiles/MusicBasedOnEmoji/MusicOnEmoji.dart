import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/uifiles/MusicBasedOnEmoji/music_player_page.dart';
import 'package:myapp/uifiles/MusicOnMoodFace/recentlyplayed.dart';
import 'package:myapp/uifiles/profile.dart';
import 'package:myapp/services/CRUD.dart'; 

class MusicOnEmoji1 extends StatelessWidget {
  final String mood;
  final String email;

  const MusicOnEmoji1({Key? key, required this.mood, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music for $mood'),
      ),
      body: _buildMediaCards(context, mood, email),
    );
  }
}

Widget _buildMediaCards(BuildContext context, String mood, String email) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('media').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      }

      final documents = snapshot.data!.docs;

      final topSongs = documents.where((doc) => (doc.data() as Map<String, dynamic>)['type'] == mood).toList();

      int rowCount = (topSongs.length / 2).ceil();

      return ListView.builder(
        itemCount: rowCount,
        itemBuilder: (context, index) {
          int startIndex = index * 2;
          int endIndex = startIndex + 1;

          return Row(
            children: [
              if (startIndex < topSongs.length) _buildCard(context, topSongs[startIndex], email),
              SizedBox(width: 16),
              if (endIndex < topSongs.length) _buildCard(context, topSongs[endIndex], email),
            ],
          );
        },
      );
    },
  );
}

Widget _buildCard(BuildContext context, QueryDocumentSnapshot<Object?> song, String email) {
  final data = song.data() as Map<String, dynamic>;
  final title = data['title'] ?? '';
  final author = data['author'] ?? '';
  final imageUrl = data['imageUrl'] ?? '';
  final musicUrl = data['musicUrl'] ?? '';

  return Expanded(
    child: GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicPlayerPage(
              musicUrl: musicUrl,
              imageUrl: imageUrl,
              title: title,
              author: author,
            ),
          ),
        );

        addToRecentlyPlayed(email, title);
      },
      child: Card(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error');
                      return Text('Error loading image');
                    },
                  )
                : Placeholder(
                    fallbackHeight: 200,
                    color: Colors.grey,
                  ),
            ListTile(
              title: Text(title),
              subtitle: Text('Author: $author'),
            ),
            ButtonBar(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayerPage(
                          musicUrl: musicUrl,
                          imageUrl: imageUrl,
                          title: title,
                          author: author,
                        ),
                      ),
                    );
                    addToRecentlyPlayed(email, title);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow),
                      SizedBox(width: 4),
                      Text('Play'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
