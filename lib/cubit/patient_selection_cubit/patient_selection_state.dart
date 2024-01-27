part of 'patient_selection_cubit.dart';

@immutable
sealed class PatientSelectionState {}

final class PatientSelectionInitial extends PatientSelectionState {}

final class PatientListCreated extends PatientSelectionState {
  final List patients;
  PatientListCreated({required this.patients});
}

class PatientSelected extends PatientSelectionState {
  final String patientName;
  final int mrn;
  final String docId;
  PatientSelected(
      {required this.patientName, required this.mrn, required this.docId});
}

late double trophic;
late double feedingGIR;
late double feedingLipid;
late double feedingProtein;
String weight = "";
String mlKg = "";
String restriction = "";
String addition = "";
String feeding = "";
String drugs = "";
String netVolumeResult = "";
bool showWeightModal = false;
late double weightDB;
late double minGlucoseConcentration;
late double maxGlucoseConcentration;
