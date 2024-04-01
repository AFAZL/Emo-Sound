import 'package:cloud_firestore/cloud_firestore.dart';

// Create
createUser(String name, String surname, String email, DateTime? date,
    String gender) async {
  await FirebaseFirestore.instance.collection('User').doc(email).set({
    'Name': name,
    'Surname': surname,
    'Email': email,
    'DOB': date,
    'Gender': gender,
    'date': DateTime.now(),
  });
  print("Database Done");
}

// Read
// Read a particular document
readUser(String collection, String docId) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .doc(docId)
        .get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> userData =
          documentSnapshot.data() as Map<String, dynamic>;
      // Accessing individual fields
      String name = userData['Name'];
      String surname = userData['Surname'];
      String email = userData['Email'];
      DateTime? date = userData['Date'] != null
          ? (userData['Date'] as Timestamp).toDate()
          : null;
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
UpdateUser(String collection, String docname, String feild,
    String newfeildvalue) async {
  await FirebaseFirestore.instance.collection(collection).doc(docname).update({
    feild: newfeildvalue,
  });
  print("Database update Done");
}

// Delete
// DeleteUser('User','Afzal@gmail.com');

DeleteUser(String collection, String docname) async {
  await FirebaseFirestore.instance.collection(collection).doc(docname).delete();
  print("Database Delete Done");
}

// Retrieve data based on name for Profile page

// Read a document based on its name
Future<Map<String, dynamic>> readUserByName(
    String collection, String name) async {
  try {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection(collection).doc(name).get();
    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      throw 'Document does not exist';
    }
  } catch (e) {
    throw 'Error reading document: $e';
  }
}

// Get Data of the collection 

Future<List<Map<String, dynamic>>> readCollectionByName(String collection) async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    List<Map<String, dynamic>> dataList = [];

    querySnapshot.docs.forEach((document) {
      dataList.add(document.data() as Map<String, dynamic>);
    });

    return dataList;
  } catch (e) {
    throw 'Error Reading Collection:$collection';
  }
}
