import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tpn/components/helpers/patient.dart';
import 'package:flutter_tpn/components/helpers/perfusion_data.dart';
import 'package:flutter_tpn/components/helpers/request_parameter.dart';
import 'package:flutter_tpn/data/previous_data_firebase.dart';

part 'patient_selection_state.dart';

class PatientSelectionCubit extends Cubit<PatientSelectionState> {
  PatientSelectionCubit() : super(PatientSelectionInitial());

  void patientSelectionInitial() async {
    final patientData = GettingData();

    final patientList = await patientData.fetchCurrentPatients();
    final patientNames = patientList.map((patient) => patient).toList();

    emit(PatientListCreated(patientsName: patientNames));
  }

  void getOldTpnRequest(Patient tpatient) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      emit(PatientSelected(patient: tpatient));
    } catch (e) {
      print(e);
    }
  }
}
