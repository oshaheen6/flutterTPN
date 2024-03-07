part of 'patient_selection_cubit.dart';

abstract class PatientSelectionState extends Equatable {}

class PatientSelectionInitial extends PatientSelectionState {
  @override
  List<Object?> get props => [];
}

class PatientListCreated extends PatientSelectionState {
  final List<Patient> patientsName;

  PatientListCreated({required this.patientsName});

  @override
  List<Object?> get props => [patientsName];
}

class PatientSelected extends PatientSelectionState {
  final Patient patient;

  PatientSelected({required this.patient});

  @override
  List<Object?> get props => [patient];
}

class SetRequest extends PatientSelectionState {
  final RequestParameter request;

  SetRequest({required this.request});
  @override
  List<Object?> get props => [request];
}

class SetPerfusion extends PatientSelectionState {
  final PerfusionData perfusion;
  SetPerfusion({required this.perfusion});

  @override
  List<Object?> get props => [perfusion];
}
