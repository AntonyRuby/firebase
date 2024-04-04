import 'package:firebase/age.dart';
import 'package:firebase/otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBasexdeOYdysOSrNFrnA0OaHINgEsZh24',
          appId: '1:570207801157:web:81bc2f24487762c6cc782c',
          messagingSenderId: '570207801157',
          projectId: 'flutterproject-dda07'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Firebase',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OtpScreen()),
                );
              },
              child: const Text('Verify Phone Number'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AgeScreen()),
                );
              },
              child: const Text('Age'),
            ),
          ],
        ),
      ),
    );
  }
}
