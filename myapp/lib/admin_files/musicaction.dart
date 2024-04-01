import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/CRUD.dart';

class MusicAction extends StatelessWidget {
  const MusicAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Actions', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: readCollectionByName("movie"),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> userData = snapshot.data ?? [];
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allow horizontal scrolling
              child: DataTable(
                columnSpacing: 20, // Add spacing between columns
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Date Added')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: userData.map((data) {
                  DateTime registrationDate = (data['DateAdded'] as Timestamp).toDate(); 
                  String formattedDate = '${registrationDate.day}/${registrationDate.month}/${registrationDate.year}'; 
                  return DataRow(cells: [
                    DataCell(Text(data['name'] ?? '')),
                    DataCell(Text(data['type'] ?? '')),
                    DataCell(Text(formattedDate)),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              // DeleteUser("User", data['Email']);
                              // Fluttertoast.showToast(msg: "Deleted");
                              Navigator.pushReplacementNamed(context, "/MusicAction");
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              // Add action
                            },
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
