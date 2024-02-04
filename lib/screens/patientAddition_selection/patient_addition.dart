import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientAddition extends StatefulWidget {
  @override
  _PatientAdditionState createState() => _PatientAdditionState();
}

class _PatientAdditionState extends State<PatientAddition> {
  late final TextEditingController patientNameController =
      TextEditingController();
  late final TextEditingController mrnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Screen"),
      ),
      body: SingleChildScrollView(
        // Changed ScrollView to SingleChildScrollView
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
                try {
                  final patientListRef = FirebaseFirestore.instance
                      .collection('hospitals')
                      .doc('El bakry')
                      .collection('patientList');
                  final newPatientDocRef = await patientListRef.add({
                    'patientName': patientName,
                    'mrn': mrn,
                  });

                  final patientParametersRef = FirebaseFirestore.instance.doc(
                    'hospitals/El bakry/patientParameters/${newPatientDocRef.id}',
                  );
                  await patientParametersRef.set({
                    'weight': 0,
                    'proteinPerKg': 0,
                    'GIR': 0,
                  });

                  final preparationVolumeRef = FirebaseFirestore.instance.doc(
                    'hospitals/El bakry/preparationVolume/${newPatientDocRef.id}',
                  );
                  await preparationVolumeRef.set({
                    'volume': 0,
                  });
                } catch (e) {
                  return;
                }
              },
              child: const Text("Add Patient"),
            )
          ],
        ),
      ),
    );
  }
}
