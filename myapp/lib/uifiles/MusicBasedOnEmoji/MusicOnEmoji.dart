import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/uifiles/MusicBasedOnEmoji/music_player_page.dart';



class MusicOnEmoji1 extends StatelessWidget {
  final String mood;

  const MusicOnEmoji1({Key? key, required this.mood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music for $mood'), // Display the mood in the app bar title
      ),
      body: _buildMediaCards(context, mood), // Call _buildMediaCards and pass context and mood
    );
  }
}

Widget _buildMediaCards(BuildContext context, String mood) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('media').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator()); // Display a loading indicator while fetching data
      }

      final documents = snapshot.data!.docs;

      // Filter documents based on the category field
      final topSongs = documents.where((doc) => (doc.data() as Map<String, dynamic>)['type'] == mood).toList();

      // Calculate the number of rows required
      int rowCount = (topSongs.length / 2).ceil();

      return ListView.builder(
        itemCount: rowCount,
        itemBuilder: (context, index) {
          int startIndex = index * 2;
          int endIndex = startIndex + 1;

          return Row(
            children: [
              if (startIndex < topSongs.length) _buildCard(context, topSongs[startIndex]),
              SizedBox(width: 16),
              if (endIndex < topSongs.length) _buildCard(context, topSongs[endIndex]),
            ],
          );
        },
      );
    },
  );
}

Widget _buildCard(BuildContext context, QueryDocumentSnapshot<Object?> song) {
  final data = song.data() as Map<String, dynamic>;
  final title = data['title'] ?? '';
  final author = data['author'] ?? '';
  final imageUrl = data['imageUrl'] ?? '';
  final musicUrl = data['musicUrl'] ?? '';

  return Expanded(
    child: GestureDetector(
      onTap: () {
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
                    // Navigate to MusicPlayerPage and pass the musicUrl
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
