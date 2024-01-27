import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tpn/cubit/patient_selection_cubit/patient_selection_cubit.dart';
import 'package:flutter_tpn/screens/home_screen.dart';
import 'firebase_options.dart';
import './screens/Sign_in_out/sign_in_screen.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientSelectionCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NICU TPN',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SignInScreen(),
          '/home': (context) => const HomeScreen(key: ValueKey('home_screen')),
        },
      ),
    );
  }
}
