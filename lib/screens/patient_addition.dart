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
                  final querySnapshot = await FirebaseFirestore.instance
                      .collection('hospitals')
                      .doc('El bakry')
                      .collection(
                          DateTime.now().toIso8601String().substring(0, 10))
                      .where('MRN', isEqualTo: mrn)
                      .get();

                  if (querySnapshot.docs.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Patient already exists for this date."),
                      ),
                    );
                    return;
                  }

                  final patientListRef = FirebaseFirestore.instance
                      .collection('hospitals')
                      .doc('El bakry')
                      .collection('patientList');
                  final newPatientDocRef = await patientListRef.add({
                    'patientName': patientName,
                    'MRN': mrn,
                  });

                  final patient = {
                    'patientName': patientName,
                    'id': newPatientDocRef.id,
                  };
                  Navigator.pop(context, patient);

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

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Data saved successfully to Firebase"),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "An error occurred while saving data to Firebase"),
                    ),
                  );
                }
              },
              child: const Text(
                  "Save to Firebase"), // Added a child parameter for the button
            ),
          ],
        ),
      ),
    );
  }
}
