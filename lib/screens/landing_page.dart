import 'package:flutter/material.dart';
import '../services/firebase_services.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Operations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  final AuthService _authService = AuthService(); // Inisialisasi AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('CountUs'),
        titleTextStyle: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0XFF011F6B),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                  child: Text("Our Menu",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddSubtractPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Addition and Subtraction'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OddEvenPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Odd or Even'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddSubtractPage extends StatefulWidget {
  const AddSubtractPage({Key? key}) : super(key: key);

  @override
  _AddSubtractPageState createState() => _AddSubtractPageState();
}

class _AddSubtractPageState extends State<AddSubtractPage> {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  String _result = '';

  void _calculate(bool isAddition) {
    setState(() {
      int num1 = int.tryParse(_number1Controller.text) ?? 0;
      int num2 = int.tryParse(_number2Controller.text) ?? 0;
      int result = isAddition ? num1 + num2 : num1 - num2;
      _result = 'Result: $result';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addition and Subtraction'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _number1Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Enter first number'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _number2Controller,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Enter second number'),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _calculate(true),
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () => _calculate(false),
                  child: const Text('Subtract'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _result,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OddEvenPage extends StatefulWidget {
  const OddEvenPage({Key? key}) : super(key: key);

  @override
  _OddEvenPageState createState() => _OddEvenPageState();
}

class _OddEvenPageState extends State<OddEvenPage> {
  final TextEditingController _numberController = TextEditingController();
  String _result = '';

  void _checkOddEven() {
    setState(() {
      int number = int.tryParse(_numberController.text) ?? 0;
      _result = number % 2 == 0 ? 'Even' : 'Odd';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Odd or Even'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter a number'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _checkOddEven,
              child: const Text('Check'),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Result: $_result',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
