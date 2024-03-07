import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tpn/components/helpers/request_parameter.dart';

class UploadData {
  void patientAddition(patientName, mrn) async {
    try {
      final patientListRef = FirebaseFirestore.instance
          .collection('hospitals')
          .doc('El bakry')
          .collection('patientList');
      final newPatientDocRef = await patientListRef.add({
        'patientName': patientName,
        'mrn': mrn,
        'state': 'current',
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
  }

  void addingDailyParameters(RequestParameter request) async {
    final theRequest = request.netVolume.patient;
    final theNetVolume = request.netVolume;
    try {
      final patientParametersRef = FirebaseFirestore.instance.collection(
          'hospitals/El bakry/patientParameters/${theRequest.docId}/${request.date}');

      await patientParametersRef.add({
        'mrn': theRequest.mrn,
        'patientName': theRequest.patientName,
        'date': request.date,
        'mlKg': theNetVolume.mlKg,
        'drugVolume': theNetVolume.drugVolume,
        'restrictionMlKg': theNetVolume.restrictionMlKg,
        'restrictionPercent': theNetVolume.restrictionPercent,
        'additionMlKg': theNetVolume.additionMlKg,
        'feedingAmount': theNetVolume.feedingAmount,
        'netVolume': request.netVolume,
        'infustionrate': theNetVolume.infustionRate,
        'sodiumRequired': request.sodiumRequired,
        'potassiumRequired': request.potassiumRequired,
        'magnesiumRequired': request.magnesiumRequired,
        'phosphateRequired': request.phosphateRequired,
        'traceRequied': request.traceRequired,
        'vitaminRequired': request.vitaminRequired,
        'girRequired': request.girRequired,
        'proteinRequired': request.proteinRequired,
        'lipidRequried': request.lipidRequired,
      });
    } catch (e) {
      print("Error uploading request: $e");
    }
  }
}
