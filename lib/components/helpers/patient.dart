import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String patientName;
  final String mrn;
  final String docId;
  const Patient(
      {required this.patientName, required this.mrn, required this.docId});

  @override
  List<Object> get props => [patientName, mrn, docId];
}
