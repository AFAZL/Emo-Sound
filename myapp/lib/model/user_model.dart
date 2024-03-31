import 'package:firebase_auth/firebase_auth.dart';

class User1 {
  final String id;
  final String email;


  User1({
    required this.id,
    required this.email,
  
  });

  factory User1.fromFirebase(UserCredential userCredential) {
    return User1(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
    );
  }
}
