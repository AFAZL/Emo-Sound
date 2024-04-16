import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MusicAction extends StatefulWidget {
  const MusicAction({Key? key}) : super(key: key);

  @override
  _MusicActionState createState() => _MusicActionState();
}

class _MusicActionState extends State<MusicAction> {
  late List<DocumentSnapshot> _musicDocuments = [];
  late List<DocumentSnapshot> _filteredMusicDocuments = [];
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);

    final QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('media').get();

    setState(() {
      _musicDocuments = querySnapshot.docs;
      _filteredMusicDocuments = _musicDocuments;
      _loading = false;
    });
  }

  void _filterData(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredMusicDocuments = _musicDocuments;
      } else {
        _filteredMusicDocuments = _musicDocuments.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final title = data['title']?.toString() ?? '';
          final author = data['author']?.toString() ?? '';
          final category = data['category']?.toString() ?? '';
          final type = data['type']?.toString() ?? '';
          return title.toLowerCase().contains(query.toLowerCase()) ||
              author.toLowerCase().contains(query.toLowerCase()) ||
              category.toLowerCase().contains(query.toLowerCase()) ||
              type.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Music', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterData,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: _filteredMusicDocuments.length,
              itemBuilder: (context, index) {
                final data =
                _filteredMusicDocuments[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['title']?.toString() ?? ''),
                  subtitle: Text(data['author']?.toString() ?? ''),
                  trailing: Text(data['type']?.toString() ?? ''),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
