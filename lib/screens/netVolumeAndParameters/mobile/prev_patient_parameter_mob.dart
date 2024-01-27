import 'package:flutter/material.dart';

class PrevPatientParametersMob extends StatelessWidget {
  final String patientName;

  PrevPatientParametersMob({required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patientName),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Previous Patient Parameters'),
      ),
    );
  }
}
