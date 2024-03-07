import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tpn/cubit/tpn_request/tpn_request_cubit.dart';
import '../../components/widgets/mytextfiled.dart';

class NetVolumeCalculator extends StatefulWidget {
  //final void Function(String, String) onCalculate;

  const NetVolumeCalculator({super.key});
//  const NetVolumeCalculator({required this.onCalculate});

  @override
  State<NetVolumeCalculator> createState() => _NetVolumeCalculatorState();
}

class _NetVolumeCalculatorState extends State<NetVolumeCalculator> {
  double trophic = 0;
  late double minGlucoseConcentration;
  late double maxGlucoseConcentration;

  @override
  void initState() {
    super.initState();

    context.read<TpnRequestCubit>();

//restrictionControllerSubscription = restrictionController.
    weightController.addListener(() {
      final value = weightController.text;
      context.read<TpnRequestCubit>().calculateNetVolume(
            value,
            mlKgController.text,
            restrictionController.text,
            additionController.text,
            feedingController.text,
            drugsController.text,
          );
    });

    mlKgController.addListener(() {
      final value = mlKgController.text;
      context.read<TpnRequestCubit>().calculateNetVolume(
            weightController.text,
            value,
            restrictionController.text,
            additionController.text,
            feedingController.text,
            drugsController.text,
          );
    });

    restrictionController.addListener(() {
      final value = restrictionController.text;
      context.read<TpnRequestCubit>().calculateNetVolume(
            weightController.text,
            mlKgController.text,
            value,
            additionController.text,
            feedingController.text,
            drugsController.text,
          );
    });

    additionController.addListener(() {
      final value = additionController.text;
      context.read<TpnRequestCubit>().calculateNetVolume(
            weightController.text,
            mlKgController.text,
            restrictionController.text,
            value,
            feedingController.text,
            drugsController.text,
          );
    });

    feedingController.addListener(() {
      final value = feedingController.text;
      context.read<TpnRequestCubit>().calculateNetVolume(
            weightController.text,
            mlKgController.text,
            restrictionController.text,
            additionController.text,
            value,
            drugsController.text,
          );
    });

    drugsController.addListener(() {
      final value = drugsController.text;
      context.read<TpnRequestCubit>().calculateNetVolume(
            weightController.text,
            mlKgController.text,
            restrictionController.text,
            additionController.text,
            feedingController.text,
            value,
          );
    });
  }

  TextEditingController weightController = TextEditingController();
  TextEditingController mlKgController = TextEditingController();
  TextEditingController restrictionController = TextEditingController();
  TextEditingController additionController = TextEditingController();
  TextEditingController feedingController = TextEditingController();
  TextEditingController drugsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  MyTextField(
                    label: "Weight (Kg)",
                    thecontroller: weightController,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    label: "ml/kg/day",
                    thecontroller: mlKgController,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    label: "Restriction",
                    thecontroller: restrictionController,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    label: "Addition",
                    thecontroller: additionController,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    label: "Feeding",
                    thecontroller: feedingController,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    label: "Drugs",
                    thecontroller: drugsController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<TpnRequestCubit, TpnRequestState>(
              bloc: context.read<TpnRequestCubit>(),
              builder: (context, state) {
                if (state is NetVolume) {
                  return Text("Net Volume: ${state.netVolume} ml");
                } else {
                  return const Text("Calculating...");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
