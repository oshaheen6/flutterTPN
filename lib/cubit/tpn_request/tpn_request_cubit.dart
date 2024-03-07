import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'tpn_request_state.dart';

class TpnRequestCubit extends Cubit<TpnRequestState> {
  TpnRequestCubit() : super(TpnRequestInitial());

// the declaration for calculateNetVolume & calculateMaxGir results

  double _naMl = 0;
  double _kMl = 0;
  double _mgMl = 0;
  double _phosphorusMl = 0;
  double _protienMl = 0;
  double _lipidMl = 0;
  double _vitaminMl = 0;
  double _traceMl = 0;
  final String _naConcentration = '0.9%';
  final String _traceElement = 'Addaven';
  final double _glucosePercentage = 0;

  late double weight;

  void calculateNetVolume(
      String patientWeight,
      String mlKgDay,
      String restrictionAmount,
      String additionAmount,
      String feedingAmount,
      String drugAmount) {
    double weightValue = double.tryParse(patientWeight) ?? 0;
    double mlKgValue = double.tryParse(mlKgDay) ?? 0;
    double restrictionValue = double.tryParse(restrictionAmount) ?? 0;
    double additionValue = double.tryParse(additionAmount) ?? 0;
    double feedingValue = double.tryParse(feedingAmount) ?? 0;
    double netVolume = (mlKgValue * weightValue) -
        restrictionValue +
        additionValue +
        feedingValue;

    String netVolumeResult = netVolume.toStringAsFixed(2);
    emit(NetVolume(netVolume: netVolumeResult));
  }
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

    _phosphorusMl = phParameter * 1;
    var naPhosphorus = phParameter * 2;

    _naMl = (naParameter - naPhosphorus) *
        weight *
        (_naConcentration == '0.9%' ? 6.5 : 2);

    _kMl = kParameter * weight * 0.5;
    _mgMl = mgParameter * weight * 2.5;

    _lipidMl = lipidParameter * weight * 5;
    _protienMl = proteinParameter * weight * 10;
    _vitaminMl = vitaminParameter * weight;
    _traceMl = traceParameter * weight * (_traceElement == 'Addaven' ? 0.1 : 1);

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

    double _maxGir = calculatedMaxGir;
  }
}

void saveParametersAndVolume() {
  //pass data to firebase to be saved
}
