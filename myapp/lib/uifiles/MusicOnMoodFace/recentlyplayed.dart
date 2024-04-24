import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/uifiles/MusicBasedOnEmoji/music_player_page.dart';

class RecentlyPlayedPage extends StatelessWidget {
  final String email;

  const RecentlyPlayedPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recently Played'), // Update the app bar title
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Recently Played Songs', // Display a title for recently played songs
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildRecentlyPlayedList(email), // Display the list of recently played songs
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyPlayedList(String email) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('RecentlyPlayed')
          .doc(email)
          .collection('Songs')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No recently played songs.'); // Display a message if no songs are found
        }

        final List<String> songNames = snapshot.data!.docs.map((doc) => doc['songName'] as String).toList();

        return Expanded(
          child: ListView.builder(
            itemCount: songNames.length,
            itemBuilder: (context, index) {
              return _buildSongCard(songNames[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildSongCard(String songName) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('media').doc(songName).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('Song details not found for $songName');
        }

        final songData = snapshot.data!.data() as Map<String, dynamic>;

        return ListTile(
          title: Text(songData['title'] ?? ''),
          subtitle: Text(songData['author'] ?? ''),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(songData['imageUrl'] ?? ''),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MusicPlayerPage(
                  musicUrl: songData['musicUrl'] ?? '',
                  imageUrl: songData['imageUrl'] ?? '',
                  title: songData['title'] ?? '',
                  author: songData['author'] ?? '',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
