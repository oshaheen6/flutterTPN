import 'package:equatable/equatable.dart';
import 'package:flutter_tpn/components/helpers/patient.dart';

class NetVolume extends Equatable {
  //final String netVolume;
  final String mlKg;
  final String drugVolume;
  final String restrictionMlKg;
  final String restrictionPercent;
  final String additionMlKg;
  final String feedingAmount;
  final String netVolume;
  final String infustionRate;
  final Patient patient;
  const NetVolume(
      {required this.patient,
      required this.mlKg,
      required this.drugVolume,
      required this.restrictionMlKg,
      required this.restrictionPercent,
      required this.additionMlKg,
      required this.feedingAmount,
      required this.infustionRate,
      required this.netVolume});

  @override
  List<Object?> get props => [
        patient,
        mlKg,
        drugVolume,
        restrictionMlKg,
        restrictionPercent,
        additionMlKg,
        feedingAmount,
        infustionRate,
        netVolume
      ];
}
