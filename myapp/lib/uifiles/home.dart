import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/uifiles/MusicBasedOnEmoji/music_player_page.dart';
import 'package:myapp/uifiles/profile.dart';
import 'package:just_audio/just_audio.dart'; // Import the just_audio package

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments;
    print("Home $email");
    return Scaffold(
      backgroundColor: Color(0xFF242d5c),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF242d5c)),
        backgroundColor: Color(0xFF51cffa),
        title: Text(
          'Home',
          style: TextStyle(color: Color(0xFF242d5c)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('Email before navigation: $email');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(email: '$email')),
              );
            },
            icon: Icon(
              Icons.person,
              color: Color(0xFF242d5c),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: Icon(
              Icons.logout,
              color: Color(0xFF242d5c),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF51cffa),
              ),
              child: Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Color(0xFF242d5c)),
              title: Text('Home', style: TextStyle(color: Color(0xFF242d5c))),
              onTap: () {
                Navigator.pushNamed(context, '/test');
              },
            ),
            ListTile(
              leading: Icon(Icons.music_note, color: Color(0xFF242d5c)),
              title: Text('Mood Based Music',
                  style: TextStyle(color: Color(0xFF242d5c))),
              onTap: () {
                Navigator.pushNamed(context, '/MusicOnMood');
              },
            ),
            ListTile(
              leading: Icon(Icons.mood, color: Color(0xFF242d5c)),
              title: Text('Emoji Based Music',
                  style: TextStyle(color: Color(0xFF242d5c))),
              onTap: () {
                Navigator.pushNamed(context, '/emoji');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFF242d5c)),
              title:
                  Text('Settings', style: TextStyle(color: Color(0xFF242d5c))),
              onTap: () {
                Navigator.pushNamed(context, '/test');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150, // Adjust the height of the banner as needed
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF242d5c).withOpacity(0.6),
                    Color(0xFF242d5c).withOpacity(0.2),
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/banner.jpg'), // Placeholder image URL
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Trending Songs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            _buildMediaCards(
                context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Top Songs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            _buildMediaCards1(
                context),// Pass the BuildContext to _buildMediaCards
          ],
        ),
      ),
    );
  }

  Widget _buildMediaCards(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('media').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        }

        final documents = snapshot.data!.docs;

        // Filter documents based on the category field
        final topSongs = documents.where((doc) => (doc.data() as Map<String, dynamic>)['category'] == 'Top Hit').toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: topSongs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final title = data['title'] ?? '';
              final author = data['author'] ?? '';
              final category = data['category'] ?? '';
              final imageUrl = data['imageUrl'] ?? '';
              final musicUrl = data['musicUrl'] ?? '';
              final type = data['type'] ?? '';

              print('Title: $title, Image URL: $imageUrl');

              return _buildCard(context, title, author, category, imageUrl,
                  musicUrl, type); // Pass the BuildContext to _buildCard
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildMediaCards1(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('media').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        }

        final documents = snapshot.data!.docs;

        // Filter documents based on the category field
        final topSongs = documents.where((doc) => (doc.data() as Map<String, dynamic>)['category'] == 'Trending').toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: topSongs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final title = data['title'] ?? '';
              final author = data['author'] ?? '';
              final category = data['category'] ?? '';
              final imageUrl = data['imageUrl'] ?? '';
              final musicUrl = data['musicUrl'] ?? '';
              final type = data['type'] ?? '';

              print('Title: $title, Image URL: $imageUrl');

              return _buildCard(context, title, author, category, imageUrl,
                  musicUrl, type); // Pass the BuildContext to _buildCard
            }).toList(),
          ),
        );
      },
    );
  }



  Widget _buildCard(BuildContext context, String title, String author,
      String category, String imageUrl, String musicUrl, String type) {
    return GestureDetector(
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
      child: Container(
        width: 200, // Adjust the width of the card
        child: Card(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 100,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: $error');
                        return Text('Error loading image');
                      },
                    )
                  : Placeholder(
                      fallbackHeight: 100,
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
}
