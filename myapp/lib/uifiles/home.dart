import 'package:flutter/material.dart';
import 'package:myapp/uifiles/profile.dart';

class HomePage extends StatelessWidget {
  final List<String> topSongs = [
    'Song 1',
    'Song 2',
    'Song 3',
    'Song 4',
    'Song 5',
  ];

  final List<String> suggestions = [
    'Suggestion 1',
    'Suggestion 2',
    'Suggestion 3',
    'Suggestion 4',
    'Suggestion 5',
  ];

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
          style: TextStyle(color: Color(0xFF242d5c) ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('Email before navigation: $email');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(email: '$email')),
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
                Navigator.pop(context);
                // Navigate to home page
              },
            ),
            
            ListTile(
              leading: Icon(Icons.music_note, color: Color(0xFF242d5c)),
              title: Text('Emoji Based Music', style: TextStyle(color: Color(0xFF242d5c))),
              onTap: () {
                Navigator.pop(context);
                // Add navigation to Emoji Based Music page
              },
            ),
            ListTile(
              leading: Icon(Icons.mood, color: Color(0xFF242d5c)),
              title: Text('Mood Based Music', style: TextStyle(color: Color(0xFF242d5c))),
              onTap: () {
                Navigator.pop(context);
                // Add navigation to Mood Based Music page
              },

            ),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFF242d5c)),
              title: Text('Settings', style: TextStyle(color: Color(0xFF242d5c))),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings page
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
                  image: AssetImage('assets/images/banner.jpg'), // Placeholder image URL
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
            _buildSlider('Top Songs', topSongs),
            _buildSlider('Suggestions for You', suggestions),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // Set text color to white
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        items[index],
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Add action for the button here
                        },
                        child: Text('Play'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
