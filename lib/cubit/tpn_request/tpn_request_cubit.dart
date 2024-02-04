import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'tpn_request_state.dart';

class TpnRequestCubit extends Cubit<TpnRequestState> {
  TpnRequestCubit() : super(TpnRequestInitial());

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

  late double _maxGir;
  double _naMl = 0;
  double _kMl = 0;
  double _mgMl = 0;
  double _phosphorusMl = 0;
  double _protienMl = 0;
  double _lipidMl = 0;
  double _vitaminMl = 0;
  double _traceMl = 0;
  String _naConcentration = '0.9%';
  String _traceElement = 'Addaven';
  double _glucosePercentage = 0;

  late double weight;

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

    double na = double.tryParse(naController.text) ?? 0;
    double k = double.tryParse(kController.text) ?? 0;
    double mg = double.tryParse(mgController.text) ?? 0;
    double phosphorus = double.tryParse(phosphorusController.text) ?? 0;
    double traceElement = double.tryParse(traceElementController.text) ?? 0;
    double vitamins = double.tryParse(vitaminsController.text) ?? 0;
    double protein = double.tryParse(proteinController.text) ?? 0;
    double lipid = double.tryParse(lipidController.text) ?? 0;

    _phosphorusMl = phosphorus * 1;
    var naPhosphorus = phosphorus * 2;

    _naMl =
        (na - naPhosphorus) * weight * (_naConcentration == '0.9%' ? 6.5 : 2);

    _kMl = k * weight * 0.5;
    _mgMl = mg * weight * 2.5;

    _lipidMl = lipid * weight * 5;
    _protienMl = protein * weight * 10;
    _vitaminMl = vitamins * weight;
    _traceMl = traceElement * weight * (_traceElement == 'Addaven' ? 0.1 : 1);

    double glucoseVolume = netVolume -
        (_lipidMl +
            _protienMl +
            _naMl +
            _kMl +
            _mgMl +
            _phosphorusMl +
            _traceMl +
            _vitaminMl);
    double calculatedMaxGir =
        glucoseVolume / 24 * 25 / (6 * weight) * (1 + _glucosePercentage / 100);

    _maxGir = calculatedMaxGir;
  }
}

void saveParametersAndVolume() {
  //pass data to firebase to be saved
}
