import 'package:firebase_auth/firebase_auth.dart';
import 'package:satu/screens/register_screen.dart';
import 'package:satu/screens/welcome.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Mendapatkan user yang sedang login
  User? get currentUser => _auth.currentUser;

  // Login dengan email dan password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error during sign in: ${e.message}");
      return null;
    }
  }

  // Daftar dengan email dan password
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error during registration: ${e.message}");
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error during sign out: ${e}");
    }
  }

  // Sign Up

  // Fungsi untuk mengirim email reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error during password reset: ${e.toString()}");
      throw e; // Lempar exception agar bisa ditangkap di layar ForgetPasswordScreen
    }
  }

  // Mendengarkan perubahan status auth
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
