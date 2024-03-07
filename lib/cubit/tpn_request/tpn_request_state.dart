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
  NetVolume({required this.netVolume});
}
