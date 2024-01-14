import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isSignedIn = prefs.getBool('isLoggedIn') ?? false;
    _isLoggedIn = isSignedIn;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    try {
      // Sign the user in with their email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Set the user's sign-in state to true and save it in local storage and cache
      _isLoggedIn = true;
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      prefs.setBool("isCached", true);

      // Notify listeners that the sign-in state has changed
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOut() async {
    try {
      // Sign the user out
      await FirebaseAuth.instance.signOut();

      // Set the user's sign-in state to false and save it in local storage and cache
      _isLoggedIn = false;
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", false);
      prefs.setBool("isCached", true);

      // Notify listeners that the sign-in state has changed
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
