import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String patientName;
  final String docId;
  final num mrn;

  Patient({required this.patientName, required this.docId, required this.mrn});
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String mainCollectionPath = 'hospitals';
  CollectionReference get mainCollectionRef =>
      _db.collection(mainCollectionPath);

  CollectionReference allPatient(String documentPath) => _db
      .collection(mainCollectionPath)
      .doc(documentPath)
      .collection('patientList');
}

class MyWidget {
  MyWidget();

  final FirestoreService db = FirestoreService();
  Future<List<Patient>> fetchPatients() async {
    final patientDataRef = db.allPatient('el bakry');

    final querySnapshot = await patientDataRef.get();

    final patients = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Patient(
          patientName: data['patientName'], docId: doc.id, mrn: data['mrn']);
    }).toList();

    return patients;
  }

// i want to add method or class to get all current patient list

// i want to add method or class to get all current or not current patient into list

// i want to get the days that is saved in for the patient taking TPN

// i want to recall the tpn request for certain patient in a certain day

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

    List<Map<String, dynamic>> patientList() {
      return [
        {'patientName': 'Osama'},
        {'MRN': 2}
      ];
    }
  }

// used as templet to decrease firestore code and easy to maintain
//   money(t) {
//     final FirestoreService db = FirestoreService();
//     var documentPath = t;
//     const mainCollectionPath = 'trackMoney';
//     final mainCollectionRef = db.collection(mainCollectionPath);
//     final documentRef = mainCollectionRef.doc(documentPath);

//     const income = 'income';
//     const expense = 'expense';

//     final incomeRef = documentRef.collection(income);
//     final expenseRef = documentRef.collection(expense);

// // Create a new user with a first and last name
//     void incomeAddition() {
//       final user = <String, dynamic>{"first": "Ada"};

// // Add a new document with a generated ID
//       incomeRef.doc(t).set(user);
//     }
//   }
}
