import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              scrollDirection: Axis.horizontal, // Set horizontal scroll direction
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email'), numeric: true), // Set numeric to prevent excessive expansion
                    DataColumn(label: Text('Gender')),
                    DataColumn(label: Text('Date Added')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: userData.map((data) {
                    DateTime? registrationDate = (data['date'] as Timestamp?)?.toDate(); // Convert Timestamp to DateTime
                    String formattedDate = registrationDate != null ? '${registrationDate.day}/${registrationDate.month}/${registrationDate.year}' : ''; // Format DateTime as string
                    String truncatedEmail = (data['Email'] as String?)?.substring(0, 15) ?? ''; // Truncate email to a certain length
                    return DataRow(cells: [
                      DataCell(Text(data['Name'] ?? '')),
                      DataCell(Text(truncatedEmail)), // Display truncated email
                      DataCell(Text(data['Gender'] ?? '')),
                      DataCell(Text(formattedDate)), // Display formatted date
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              DeleteUser("User", data['Email']);
                              Fluttertoast.showToast(msg: "Deleted");
                              Navigator.pushReplacementNamed(context, "/UserAction");
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
              ),
            );
          }
        },
      ),
    );
  }
}
