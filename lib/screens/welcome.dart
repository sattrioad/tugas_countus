// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'landing_page.dart'; // Import file landing_page.dart
import '../services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart';
import 'forgetpassword.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Inisialisasi AuthService
  bool isLoading = false;

  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    late final dynamic user;
    try {
      final user = await _authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      if (user != null) {
        print('User logged in: ${user.email}');
        // Tampilkan notifikasi sukses
        _showNotification('Login berhasil', Colors.green);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      } else {
        throw FirebaseAuthException(code: 'null-user');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Tidak ada pengguna dengan email ini.';
          break;
        case 'wrong-password':
          errorMessage = 'Password yang dimasukkan salah.';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid.';
          break;
        case 'user-disabled':
          errorMessage = 'Akun pengguna ini telah dinonaktifkan.';
          break;
        case 'null-user':
          errorMessage = 'Login Gagal';
          break;
        default:
          errorMessage = 'Terjadi kesalahan: ${e.message}';
      }
      _showNotification(errorMessage, Colors.red);
      print('Login error: $errorMessage');
    } catch (e) {
      _showNotification('Terjadi kesalahan yang tidak diketahui.', Colors.red);
      print('Unexpected error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showNotification(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0XFF011F6B),
      body: Stack(
        children: [
          Container(
            child: isLoading ? Text("loading...") : null,
          ),
          Positioned(
            top: 100, // Posisi dari atas
            left: 0,
            right: 0, // Agar tetap di tengah secara horizontal
            child: Image.asset(
              'assets/images/Group.png',
              height: 810, // Sesuaikan tinggi gambar
              width: 810, // Sesuaikan lebar gambar
              fit: BoxFit.cover, // Mengatur agar gambar memenuhi
            ),
          ),
          const Positioned(
            top: 350, // Atur posisi teks di atas gambar
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Login", // Teks yang ingin ditampilkan
                style: TextStyle(
                  color: Color(0XFF011F6B), // Warna teks
                  fontSize: 30, // Ukuran font teks
                  fontWeight: FontWeight.bold, // Ketebalan font
                ),
              ),
            ),
          ),
          const Positioned(
            top: 400, // Atur posisi teks di atas gambar
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Please login to your account \nto use our features", // Teks yang ingin ditampilkan
                textAlign: TextAlign.center, // Mengatur teks rata tengah
                style: TextStyle(
                  color: Color(0XFF011F6B), // Warna teks
                  fontSize: 17, // Ukuran font teks
                  fontWeight: FontWeight.normal, // Ketebalan font
                ),
              ),
            ),
          ),
          Positioned(
            top: 490, // Posisi form di bawah teks
            left: 30,
            right: 30,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0XFF8A8888)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(color: Color(0XFF011F6B)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0XFF8A8888)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(color: Color(0XFF011F6B)),
                ),
                SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft, // Align kiri
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPasswordScreen()),
                      );
                      // Fungsi untuk "Forgot Password"
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0XFF011F6B),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF011F6B), // Warna tombol
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: Text(
                    "Don't have an account?", // Teks don't have an account
                    style: TextStyle(
                      color: Color(0XFF011F6B),
                      fontSize: 14,
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                      // Fungsi untuk navigasi ke halaman signup
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        color: Color(0XFF011F6B),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
