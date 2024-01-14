import 'package:flutter/material.dart';
import 'prev_patient_parameter_mob.dart';

class PatientParametersMob extends StatelessWidget {
  final String patientName;

  const PatientParametersMob({required this.patientName});

  void _navigateToPrevPatientParameters(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PrevPatientParametersMob(patientName: patientName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patientName),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _navigateToPrevPatientParameters(context),
          ),
        ],
      ),
      body: const Center(
        child: Text('Patient Parameters'),
      ),
    );
  }
}
