import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'patient_selection_state.dart';

class PatientSelectionCubit extends Cubit<PatientSelectionState> {
  PatientSelectionCubit() : super(PatientSelectionInitial());

  List patients = ['osama', 'shaheen'];

// the declaration for calculateNetVolume & calculateMaxGir results
  int netVolume = 0;
  int maxGir = 0;

// controllers for calculateNetVolume
  TextEditingController weightController = TextEditingController();
  TextEditingController mlKgController = TextEditingController();
  TextEditingController restrictionMlorPercentontroller =
      TextEditingController();
  TextEditingController restrictionValueController = TextEditingController();
  TextEditingController additionMlorPercentController = TextEditingController();
  TextEditingController additionValueController = TextEditingController();
  TextEditingController feedingController = TextEditingController();
  TextEditingController drugsController = TextEditingController();

// controllers for calculateMaxGir
  TextEditingController naController = TextEditingController();
  TextEditingController kController = TextEditingController();
  TextEditingController mgController = TextEditingController();
  TextEditingController phosphorusController = TextEditingController();
  TextEditingController traceElementController = TextEditingController();
  TextEditingController vitaminsController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController lipidController = TextEditingController();
  TextEditingController girController = TextEditingController();

  void calculateNetVolume(
      int patientWeight,
      int mlKgDay,
      String restrictionMlorPercent,
      int restrictionValue,
      String additionMlofPercent,
      int addtionValue,
      int feedingAmount,
      int drugAmount) {}
//change the controller to int

//Ml or percent logic

// netVolume calculation

//return netVolume

  void calculateMaxGir(
      int patientWeight,
      int netVolume,
      int naParameter,
      int kParameter,
      int mgParameter,
      int phParameter,
      int traceParameter,
      int vitaminParameter,
      int proteinParameter,
      int lipidParameter) {
// convert controller to int

//calculate each parameter volume

//calculate maxGir
  }

  void saveParametersAndVolume() {
    //pass data to firebase to be saved
  }
}
