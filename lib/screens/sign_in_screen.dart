import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'print_screen.dart';
import 'calculation_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email = '';
  String password = '';

  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the appropriate screen based on the platform
      if (kIsWeb) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PrintScreen()),
        );
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NetVolumeCalculator()),
        );
      } else if (Theme.of(context).platform == TargetPlatform.android) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NetVolumeCalculator()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Const Text('osama'),
            TextField(
              onChanged: (value) => email = value,
              decoration: const InputDecoration(hintText: 'Enter your email'),
            ),
            TextField(
              onChanged: (value) => password = value,
              decoration:
                  const InputDecoration(hintText: 'Enter your password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign in'),
            )
          ],
        ),
      ),
    );
  }
}
