import 'package:flutter/material.dart';

import 'package:flutter_tpn/components/helpers/standard_appbar.dart';
import 'package:flutter_tpn/data/storing_daily_data_firebase.dart';
import 'package:flutter_tpn/screens/patientAddition_selection/patient_selection.dart';

class PatientAddition extends StatefulWidget {
  const PatientAddition({super.key});

  @override
  PatientAdditionState createState() => PatientAdditionState();
}

class PatientAdditionState extends State<PatientAddition> {
  final uploadData = UploadData();
  late final TextEditingController patientNameController =
      TextEditingController();
  late final TextEditingController mrnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(
        title: ("Patient Addition"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: patientNameController,
                decoration: const InputDecoration(
                  labelText: "Patient Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: mrnController,
                decoration: const InputDecoration(
                  labelText: "MRN",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final patientName = patientNameController.text;
                final mrn = mrnController.text;
                uploadData.patientAddition(patientName, mrn);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HospitalSelectPatient(),
                    ));
              },
              child: const Text("Add Patient"),
            )
          ],
        ),
      ),
    );
  }
}
