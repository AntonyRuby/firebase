import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String _verificationId = '';

  Future<void> _verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          print(
              'Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone number verification failed: $e');
        },
        codeSent: (String verificationId, int? resendToken) {
          print('Code sent to ${_phoneNumberController.text}');
          _verificationId = verificationId;
          print(_verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        timeout: const Duration(seconds: 120),
      );
    } catch (e) {
      print('Error during phone number verification: $e');
    }
  }

  Future<void> _verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );

      await _auth.signInWithCredential(credential);
      print('User signed in: ${_auth.currentUser!.uid}');
    } catch (e) {
      print('Error during OTP verification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: const Text('Send OTP'),
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
