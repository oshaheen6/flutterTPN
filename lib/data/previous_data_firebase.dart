import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tpn/components/helpers/net_volume.dart';
import 'package:flutter_tpn/components/helpers/patient.dart';
import 'package:flutter_tpn/components/helpers/request_parameter.dart';

class GettingData {
  GettingData();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String mainCollectionPath = 'hospitals';
  CollectionReference get mainCollectionRef =>
      db.collection(mainCollectionPath);

  CollectionReference allPatient(String documentPath) => db
      .collection(mainCollectionPath)
      .doc(documentPath)
      .collection('patientList');

  Future<List<Patient>> fetchCurrentPatients() async {
    final patientDataRef = allPatient('El bakry');

    final querySnapshot =
        await patientDataRef.where("state", isEqualTo: "current").get();

    final patients = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Patient(
          patientName: data['patientName'], docId: doc.id, mrn: data['mrn']);
    }).toList();

    return patients;
  }

  Future<List<DateTime>> getAllDates(String docId) async {
    try {
      final patientParametersRef = FirebaseFirestore.instance
          .collection('hospitals/El bakry/patientParameters/$docId');

      final snapshots = await patientParametersRef.get();
      final dates = snapshots.docs
          .map((snapshot) => snapshot.data()['date'] as DateTime)
          .toList();
      return dates.toSet().toList();
    } catch (e) {
      print("Error getting dates: $e");
      return [];
    }
  }

  Future<RequestParameter> getDailyParameters(String docId, String date) async {
    try {
      final patientParametersRef = FirebaseFirestore.instance
          .collection('hospitals/El bakry/patientParameters/$docId')
          .where('date', isEqualTo: date);

      final snapshot = await patientParametersRef.get();

      final data = snapshot.docs as Map<String, dynamic>;
      return RequestParameter(
        netVolume: NetVolume(
          patient: Patient(
              docId: data['docId'],
              patientName: data['patientName'],
              mrn: data['mrn']),
          infustionRate: data['infusionRate'],
          netVolume: data['netVolume'],
          mlKg: data['mlKg'],
          drugVolume: data['drugVolume'],
          restrictionMlKg: data['restrictionMlKg'],
          restrictionPercent: data['restrictionPercent'],
          additionMlKg: data['additionMlKg'],
          feedingAmount: data['feedingAmount'],
        ),
        date: data['date'],
        sodiumRequired: data['sodiumRequired'],
        potassiumRequired: data['potassiumRequired'],
        magnesiumRequired: data['magnesiumRequired'],
        phosphateRequired: data['phosphateRequired'],
        traceRequired: data['traceRequied'],
        vitaminRequired: data['vitaminRequired'],
        girRequired: data['girRequired'],
        proteinRequired: data['proteinRequired'],
        lipidRequired: data['lipidRequried'],
      );
    } catch (e) {
      // Handle errors appropriately
      print("Error getting request: $e");
      // ignore: null_argument_to_non_null_type
      return Future.value(null);
    }
  }
}
