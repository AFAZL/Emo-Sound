import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, int>> retrieveGenderCounts(String collection) async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    int maleCount = 0;
    int femaleCount = 0;
    int otherCount = 0;

    querySnapshot.docs.forEach((document) {
      Map<String, dynamic> userData =
          document.data() as Map<String, dynamic>;
      String gender = userData['Gender'];
      if (gender.toUpperCase() == 'MALE') {
        maleCount++;
      } else if (gender.toUpperCase() == 'FEMALE') {
        femaleCount++;
      } else {
        otherCount++;
      }
    });

    return {
      'male': maleCount,
      'female': femaleCount,
      'other': otherCount,
    };
  } catch (e) {
    throw 'Error retrieving gender counts: $e';
  }
}
