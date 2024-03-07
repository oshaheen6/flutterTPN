import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:routemaster/routemaster.dart';

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
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: loginData.name,
            password: loginData.password,
          );

          if (Theme.of(context).platform == TargetPlatform.iOS) {
            Routemaster.of(context).push('/patient_selection');
          } else {
            Routemaster.of(context).push('/patient_selection');
          }

          return null;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'auth/user-not-found') {
          } else if (e.code == 'wrong-password') {
            return 'Wrong password provided for that user.';
          } else {
            return 'Error signing in. Please try again later.';
          }
        }
        return null;
      },
      onSignup: (loginData) {
        return null;
      },
      onRecoverPassword: (email) async {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

          return 'Password reset email sent. Please check your inbox.';
        } catch (error) {
          return 'Error sending password reset email. Please try again later.';
        }
      },
      onSubmitAnimationCompleted: () {
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          Routemaster.of(context).push('/patient_selection');
        } else {
          Routemaster.of(context).push('/patient_selection');
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
