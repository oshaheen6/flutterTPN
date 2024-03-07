import 'package:equatable/equatable.dart';

class PerfusionData extends Equatable {
  final String netVolume;
  const PerfusionData({required this.netVolume});

  @override
  List<Object> get props => [netVolume];
}
