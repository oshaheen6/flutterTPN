import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'patient_addition.dart';
import 'sign_in_screen.dart';
import 'components/context/auth_provider.dart';
import 'package:provider/provider.dart';

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

  final storage = new FlutterSecureStorage();

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
      savePatientListOffline(patientNames);
    }
  }

  Future<void> savePatientListOffline(
      List<Map<String, dynamic>> patientList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("patientList", jsonEncode(patientList));
      print("Patient list saved offline.");
    } catch (error) {
      print("Error saving patient list offline: $error");
    }
  }

  Future<void> loadPatientListOffline() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final patientListJson = prefs.getString("patientList");
      if (patientListJson != null) {
        List<dynamic> patientList = jsonDecode(patientListJson);
        setState(() {
          patientNames = List<Map<String, dynamic>>.from(patientList);
          filteredPatients = List<Map<String, dynamic>>.from(patientList);
        });
        print("Patient list loaded from local storage.");
      }
    } catch (error) {
      print("Error loading patient list from local storage: $error");
    }
  }

  Future<void> getPatientNames() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('Offline');
      return;
    }
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

    await savePatientListOffline(allPatientData);
  }

  @override
  void initState() {
    super.initState();
    loadPatientListOffline();
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
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text('My App'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Sign out the user and navigate to the sign in screen
                authProvider.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
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
                ? Center(
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
                child: Text("Select"),
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
              ),
              ElevatedButton(
                child: Text("Add Patient"),
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
                color: Color.fromRGBO(0, 0, 0, 0.7),
                child: Center(
                  child: PatientAddition(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
