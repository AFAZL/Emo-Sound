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
        iconTheme: IconThemeData(color: Color(0xFF242d5c)),
        backgroundColor: Color(0xFF51cffa),
        title: Text('Recently Played'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildRecentlyPlayedList(email),
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
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No recently played songs.');
        }

        final List<DocumentSnapshot> songDocs = snapshot.data!.docs;

        return Expanded(
          child: ListView.builder(
            itemCount: songDocs.length,
            itemBuilder: (context, index) {
              final songData = songDocs[index].data() as Map<String, dynamic>;
              final String songName = songData['songName'] ?? '';

              // Query the media collection to get the song details
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('media')
                    .where('title', isEqualTo: songName)
                    .get()
                    .then((querySnapshot) => querySnapshot.docs.first),
                builder: (context, mediaSnapshot) {
                  if (mediaSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (mediaSnapshot.hasError) {
                    return Text('Error: ${mediaSnapshot.error}');
                  }
                  if (!mediaSnapshot.hasData ||
                      mediaSnapshot.data == null) {
                    return Text('Song "$songName" not found.');
                  }

                  final mediaData =
                      mediaSnapshot.data!.data() as Map<String, dynamic>;

                  return ListTile(
                    title: Text(mediaData['title']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicPlayerPage(
                            musicUrl: mediaData['musicUrl'] ?? '',
                            imageUrl: mediaData['imageUrl'] ?? '',
                            title: mediaData['title'] ?? '',
                            author: mediaData['author'] ?? '',
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
