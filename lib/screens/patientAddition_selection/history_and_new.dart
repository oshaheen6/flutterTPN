import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tpn/cubit/patient_selection_cubit/patient_selection_cubit.dart';
import 'package:routemaster/routemaster.dart';

class DaySelection extends StatefulWidget {
  const DaySelection({super.key});

  @override
  State<DaySelection> createState() => _DaySelectionState();
}

class _DaySelectionState extends State<DaySelection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<PatientSelectionCubit, PatientSelectionState>(
      builder: (context, state) {
        if (state is PatientSelected) {
          return Column(
            children: [
              Text(state.patient.patientName),
              ElevatedButton(
                  onPressed: () => {Routemaster.of(context).push('/request')},
                  child: const Text("create new day"))
            ],
          );
        } else {
          return const Text("not the needed state");
        }
      },
    ));
  }
}
