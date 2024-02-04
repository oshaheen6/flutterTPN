import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../patientAddition_selection/patient_selection.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: (loginData) async {
        try {
          // Sign the user in with their email and password
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: loginData.name,
            password: loginData.password,
          );

          // Navigate to the appropriate screen based on the platform
          if (Theme.of(context).platform == TargetPlatform.iOS) {
            // If the user is using an iOS device, navigate to the HospitalSelectPatient screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HospitalSelectPatient()),
            );
          } else {
            // If the user is using an Android device, navigate to the PrintScreen screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HospitalSelectPatient()),
            );
          }

          return null;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'auth/user-not-found') {
            // Show a username error message
            //            return 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            // Show a password error message
            return 'Wrong password provided for that user.';
          } else {
            // Show a generic error message
            return 'Error signing in. Please try again later.';
          }
        }
        return null;
      },
      onSignup: (loginData) {
        // Implement the user sign-up logic here
        return null;
      },
      onRecoverPassword: (email) async {
        try {
          // Send a password reset email to the user's email address
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

          // Show a success message
          return 'Password reset email sent. Please check your inbox.';
        } catch (error) {
          // Show an error message
          return 'Error sending password reset email. Please try again later.';
        }
      },
      onSubmitAnimationCompleted: () {
        // Navigate to the appropriate screen based on the platform
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          // If the user is using an iOS device, navigate to the HospitalSelectPatient screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HospitalSelectPatient()),
          );
        } else {
          // If the user is using an Android device, navigate to the PrintScreen screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HospitalSelectPatient()),
          );
        }
      },
      title: 'TPN Bakry',
      theme: LoginTheme(
        primaryColor: Colors.blue,
      ),
      messages: LoginMessages(
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm Password',
        loginButton: 'LOG IN',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Forgot password',
        recoverPasswordButton: 'CHANGE PASSWORD',
        goBackButton: 'BACK',
        confirmPasswordError: 'Passwords do not match!',
        recoverPasswordDescription:
            'We will send you an email to reset your password.',
        recoverPasswordSuccess: 'Password reset email sent.',
        flushbarTitleError: 'Error',
        flushbarTitleSuccess: 'Success',
      ),
    );
  }
}
