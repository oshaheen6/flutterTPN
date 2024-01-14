import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'patient_selection_state.dart';

class PatientSelectionCubit extends Cubit<PatientSelectionState> {
  PatientSelectionCubit() : super(PatientSelectionInitial());
}
