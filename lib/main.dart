import 'package:flutter/material.dart';
import 'package:satu/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CountUs());
}

class CountUs extends StatelessWidget {
  const CountUs({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Inisialisasi Firebase di sini
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Cek jika inisialisasi selesai
        if (snapshot.connectionState == ConnectionState.done) {
          // Jika Firebase sudah selesai diinisialisasi, tampilkan aplikasi
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const Welcome(),
          );
        }
        // Jika inisialisasi masih berlangsung, tampilkan loading indicator
        return const CircularProgressIndicator();
      },
    );
  }
}
