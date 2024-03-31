import 'package:cloud_firestore/cloud_firestore.dart';

// Create
createUser(String name,String surname,String email,DateTime? date,String gender) async {
  await FirebaseFirestore.instance.collection('User').doc(email).set({
    'Name': name,
    'Surname': surname,
    'Email': email,
    'DOB': date,
    'Gender': gender,
    'date':DateTime.now(),
  });
  print("Database Done");
}

// Read
// Read a particular document
readUser(String collection, String docId) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection(collection).doc(docId).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
      // Accessing individual fields
      String name = userData['Name'];
      String surname = userData['Surname'];
      String email = userData['Email'];
      DateTime? date = userData['Date'] != null ? (userData['Date'] as Timestamp).toDate() : null;
      String gender = userData['Gender'];

      // Use the data as needed
      print('Name: $name');
      print('Surname: $surname');
      print('Email: $email');
      print('Date: $date');
      print('Gender: $gender');
    } else {
      print('Document does not exist');
    }
  } catch (e) {
    print('Error reading document: $e');
  }
}




// Update ------------------------------------------------------
// UpdateUser('User','sumitsawant1029@gmail.com','Name','Riya');
UpdateUser(String collection,String docname,String feild,String newfeildvalue) async {
  await FirebaseFirestore.instance.collection(collection).doc(docname).update({
    feild : newfeildvalue,
  });
  print("Database update Done");
}

// Delete
// DeleteUser('User','Afzal@gmail.com');

DeleteUser(String collection,String docname) async {
  await FirebaseFirestore.instance.collection(collection).doc(docname).delete();
  print("Database Delete Done");
}


