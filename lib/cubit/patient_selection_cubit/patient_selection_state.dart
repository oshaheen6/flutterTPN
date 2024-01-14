part of 'patient_selection_cubit.dart';

@immutable
sealed class PatientSelectionState {}

final class PatientSelectionInitial extends PatientSelectionState {}

 class PatientSelected extends PatientSelectionState{
   final String patientName ;
   final int mrn; 
    PatientSelected({required this.patientName, required this.mrn});
}