import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tpn/cubit/patient_selection_cubit/patient_selection_cubit.dart';
import 'package:flutter_tpn/cubit/tpn_request/tpn_request_cubit.dart';
import 'package:flutter_tpn/screens/netVolumeAndParameters/patient_parameters.dart';
import 'package:flutter_tpn/screens/patientAddition_selection/history_and_new.dart';
import 'package:flutter_tpn/screens/patientAddition_selection/patient_selection.dart';
import 'firebase_options.dart';
import './screens/Sign_in_out/sign_in_screen.dart';
import 'package:routemaster/routemaster.dart';

final theCubit = PatientSelectionCubit();
final theRequest = TpnRequestCubit();

final routes = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: SignInScreen()),
  '/patient_selection': (_) => MaterialPage(
        child: BlocProvider(
          create: (context) => theCubit,
          child: const HospitalSelectPatient(),
        ),
      ),
  '/patient_selection/previous_requests': (_) => MaterialPage(
        child: BlocProvider.value(
          value: theCubit,
          child: const DaySelection(),
        ),
      ),
  '/request': (_) => MaterialPage(
        child: BlocProvider.value(
            value: theRequest, child: PatientParametersScreen()),
      ),
});
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'NICU TPN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
