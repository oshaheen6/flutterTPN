import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tpn/components/helpers/patient.dart';
import 'package:flutter_tpn/components/widgets/standard_appbar.dart';
import 'package:flutter_tpn/cubit/patient_selection_cubit/patient_selection_cubit.dart';
import 'package:routemaster/routemaster.dart';
import 'patient_addition.dart';

class HospitalSelectPatient extends StatefulWidget {
  const HospitalSelectPatient({super.key});

  @override
  HospitalSelectPatientState createState() => HospitalSelectPatientState();
}

class HospitalSelectPatientState extends State<HospitalSelectPatient> {
  String? selectedPatient;
  String searchQuery = "";
  List<Patient> filteredPatients = [];
  bool modalVisible = false;

  late List allcharacters;
  @override
  void initState() {
    super.initState();

    context.read<PatientSelectionCubit>().patientSelectionInitial();
  }

  @override
  Widget build(BuildContext context) {
    void asTest(Patient thePatient) {
      setState(() {
        BlocProvider.of<PatientSelectionCubit>(context)
            .getOldTpnRequest(thePatient);
      });
    }

    return BlocBuilder<PatientSelectionCubit, PatientSelectionState>(
        builder: (context, state) {
      if (state is PatientListCreated) {
        filteredPatients = state.patientsName
            .where((patient) => patient.patientName
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search for a patient",
                  ),
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {
                      filteredPatients = state.patientsName
                          .where((patient) => patient.patientName
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: filteredPatients.isEmpty
                    ? const Center(
                        child: Text('No patients found.'),
                      )
                    : BlocListener<PatientSelectionCubit,
                        PatientSelectionState>(
                        listener: (context, state) {
                          if (state is PatientSelected) {
                            Routemaster.of(context)
                                .push('/patient_selection/previous_requests');
                          } else if (state is Error) {}
                        },
                        child: ListView.builder(
                          itemCount: filteredPatients.length,
                          itemBuilder: (context, index) {
                            final patient = filteredPatients[index];
                            return ListTile(
                              onTap: () {
                                asTest(patient);
                              },
                              title: Text(patient.patientName),
                            );
                          },
                        ),
                      ),
              ),
              ElevatedButton(
                child: const Text("Add Patient"),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PatientAddition(),
                      ))
                },
              ),
            ],
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
