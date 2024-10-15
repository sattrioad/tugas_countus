import 'package:flutter/material.dart';
import '../services/firebase_services.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final AuthService _authService = AuthService(); // Inisialisasi AuthService

  // Fungsi untuk menampilkan pop-up pesan kesalahan atau sukses
  void showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengirim permintaan reset password
  void resetPassword() async {
    String email = emailController.text.trim();

    // Validasi input
    if (email.isEmpty) {
      showMessageDialog("Email tidak boleh kosong.");
      return;
    }

    try {
      await _authService.sendPasswordResetEmail(email);
      showMessageDialog("Link reset password telah dikirim ke $email");
    } catch (e) {
      showMessageDialog("Gagal mengirim email reset password. Pastikan email sudah terdaftar.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your email to receive a password reset link:",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: resetPassword,
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
