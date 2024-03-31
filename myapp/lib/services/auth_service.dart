import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:myapp/model/user_model.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  Future<firebase_auth.User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final firebase_auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (error) {
      print("Error signing in: $error");
      return null;
    }
  }

  Future<User1?> registerWithEmailAndPassword(String email, String password) async {
    try {
      final firebase_auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Assuming User1 is your custom user model, you need to return it here
      return User1(id: userCredential.user?.uid ?? '', email: email);
    } catch (error) {
      print("Error registering user: $error");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print("Error signing out: $error");
    }
  }
}
