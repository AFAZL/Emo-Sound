import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/CRUD.dart';

class UserAction extends StatelessWidget {
  const UserAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Actions', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: readCollectionByName("User"),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> userData = snapshot.data ?? [];
            return SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: userData.map((data) {
                  DateTime registrationDate = (data['Date'] as Timestamp).toDate(); // Convert Timestamp to DateTime
                  String formattedDate = '${registrationDate.day}/${registrationDate.month}/${registrationDate.year}'; // Format DateTime as string
                  return DataRow(cells: [
                    DataCell(Text(data['Name'] ?? '')),
                    DataCell(Text(data['Email'] ?? '')),
                    DataCell(Text(data['Gender'] ?? '')),
                    DataCell(Text(formattedDate)), // Display formatted date
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            // Remove action
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle),
                          onPressed: () {
                            // Add action
                          },
                        ),
                      ],
                    )),
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
