import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tpn/cubit/patient_selection_cubit/patient_selection_cubit.dart';
import 'patient_addition.dart';
import '../Sign_in_out/sign_in_screen.dart';

class HospitalSelectPatient extends StatefulWidget {
  @override
  _HospitalSelectPatientState createState() => _HospitalSelectPatientState();
}

class _HospitalSelectPatientState extends State<HospitalSelectPatient> {
  List<Map<String, dynamic>> patientNames = [];
  String? selectedPatient;
  String searchQuery = "";
  List<Map<String, dynamic>> filteredPatients = [];
  bool modalVisible = false;

  void handleAddPatient(BuildContext context) async {
    final patient = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PatientAddition()),
    );
    if (patient != null) {
      setState(() {
        patientNames.add(patient);
        filteredPatients.add(patient);
      });
    }
  }

  Future<void> getPatientNames() async {
    final patientDataRef = FirebaseFirestore.instance
        .collection("hospitals")
        .doc("El bakry")
        .collection("patientList");

    final querySnapshot = await patientDataRef.get();
    final allPatientData = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return {
        "patientName": data["patientName"],
        "id": doc.id,
      };
    }).toList();

    setState(() {
      patientNames = allPatientData;
      filteredPatients = allPatientData;
    });
  }

  @override
  void initState() {
    super.initState();
    getPatientNames();
  }

  void handleSelectPatient(String? id) {
    setState(() {
      selectedPatient = id;
    });
  }

  void handlePress(BuildContext context) {
    if (selectedPatient == null) {
      return;
    }

    final selectedPatientName = patientNames.firstWhere(
        (patient) => patient["id"] == selectedPatient)["patientName"];

    if (kIsWeb) {
      Navigator.pushNamed(context, 'PatientParametersWeb', arguments: {
        'newPatientId': selectedPatient!,
        'patientName': selectedPatientName,
      });
    } else {
      Navigator.pushNamed(context, 'PatientParametersMob', arguments: {
        'newPatientId': selectedPatient!,
        'patientName': selectedPatientName,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientSelectionCubit, PatientSelectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
              title: const Text('My App'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    // Sign out the user and navigate to the sign in screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search for a patient",
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                      filteredPatients = patientNames
                          .where((patient) => patient["patientName"]
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: filteredPatients.isEmpty
                    ? const Center(
                        child: Text('No patients found.'),
                      )
                    : ListView.builder(
                        itemCount: filteredPatients.length,
                        itemBuilder: (context, index) {
                          final patient = filteredPatients[index];
                          return ListTile(
                            onTap: () => handleSelectPatient(patient["id"]),
                            title: Text(patient["patientName"]),
                            selected: patient["id"] == selectedPatient,
                          );
                        },
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => handlePress(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return selectedPatient == null
                              ? Colors.grey
                              : Colors.blue;
                        },
                      ),
                    ),
                    child: const Text("Select"),
                  ),
                  ElevatedButton(
                    child: const Text("Add Patient"),
                    onPressed: () => handleAddPatient(context),
                  ),
                ],
              ),
              Visibility(
                visible: modalVisible,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      modalVisible = false;
                    });
                  },
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                    child: Center(
                      child: PatientAddition(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
