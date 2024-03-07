import 'package:equatable/equatable.dart';
import 'package:flutter_tpn/components/helpers/net_volume.dart';

class RequestParameter extends Equatable {
  final String date;
  final NetVolume netVolume;
  final double sodiumRequired;
  final double potassiumRequired;
  final double magnesiumRequired;
  final double phosphateRequired;
  final bool traceRequired;
  final bool vitaminRequired;
  final double girRequired;
  final double proteinRequired;
  final double lipidRequired;

  const RequestParameter({
    required this.date,
    required this.netVolume,
    required this.sodiumRequired,
    required this.potassiumRequired,
    required this.magnesiumRequired,
    required this.phosphateRequired,
    required this.traceRequired,
    required this.vitaminRequired,
    required this.girRequired,
    required this.proteinRequired,
    required this.lipidRequired,
  });

  @override
  List<Object> get props => [
        date,
        netVolume,
        sodiumRequired,
        potassiumRequired,
        magnesiumRequired,
        phosphateRequired,
        traceRequired,
        vitaminRequired,
        girRequired,
        proteinRequired,
        lipidRequired,
      ];
}
