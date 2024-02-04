import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tpn/data/previous_data_firebase.dart';

part 'patient_selection_state.dart';

class PatientSelectionCubit extends Cubit<PatientSelectionState> {
  PatientSelectionCubit() : super(PatientSelectionInitial());

  void patientSelectionInitial() async {
    final patientData = GettingData();

    final patientList = await patientData.fetchPatients();
    final patientNames =
        patientList.map((patient) => patient.patientName).toList();

    emit(PatientListCreated(patients: patientNames));
  }

// the declaration for calculateNetVolume & calculateMaxGir results
}
