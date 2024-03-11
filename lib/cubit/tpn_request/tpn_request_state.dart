part of 'tpn_request_cubit.dart';

@immutable
sealed class TpnRequestState {}

final class TpnRequestInitial extends TpnRequestState {}

final class OldTpnRequest extends TpnRequestState {
  final List patient;
  OldTpnRequest({required this.patient});
}

final class NetVolume extends TpnRequestState {
  final String netVolume;
  final String? weight;
  final String? mlKg;
  final String? restriction;
  final String? addition;
  final String? feeding;
  final String? drugs;

  NetVolume({
    required this.netVolume,
    this.weight,
    this.mlKg,
    this.restriction,
    this.addition,
    this.feeding,
    this.drugs,
  });
}
