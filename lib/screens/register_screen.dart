import 'package:flutter/material.dart';
import '../services/firebase_services.dart';
import 'welcome.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService(); // Inisialisasi AuthService

  // Fungsi untuk menampilkan pop-up pesan kesalahan
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
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

  // Fungsi untuk melakukan validasi password
  bool validatePassword(String password) {
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    return hasLetter && hasDigit;
  }

  void registerUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Validasi input
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showErrorDialog(
          "Email, Password, dan Konfirmasi Password tidak boleh kosong.");
      return;
    }
    if (password.length < 6) {
      showErrorDialog("Password harus setidaknya 6 karakter.");
      return;
    }
    if (!validatePassword(password)) {
      showErrorDialog(
          "Password harus mengandung setidaknya satu huruf dan satu angka.");
      return;
    }
    if (password != confirmPassword) {
      showErrorDialog("Password dan Konfirmasi Password tidak sama.");
      return;
    }

    final user =
        await _authService.registerWithEmailAndPassword(email, password);
    if (user != null) {
      print('User registered: ${user.email}');
      // Navigasi ke halaman Welcome setelah berhasil register
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Welcome(),
        ),
      );
    } else {
      showErrorDialog('Registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: registerUser,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
