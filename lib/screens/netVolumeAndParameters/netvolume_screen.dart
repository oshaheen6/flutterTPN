import 'package:flutter/material.dart';
import '../../components/widgets/mytextfiled.dart';
import 'setting_screen.dart';

class NetVolumeCalculator extends StatefulWidget {
  //final void Function(String, String) onCalculate;

  const NetVolumeCalculator({super.key});
//  const NetVolumeCalculator({required this.onCalculate});

  @override
  _NetVolumeCalculatorState createState() => _NetVolumeCalculatorState();
}

class _NetVolumeCalculatorState extends State<NetVolumeCalculator> {
  late double trophic;
  late double feedingGIR;
  late double feedingLipid;
  late double feedingProtein;
  String weight = "";
  String mlKg = "";
  String restriction = "";
  String addition = "";
  String feeding = "";
  String drugs = "";
  String netVolumeResult = "";
  bool showWeightModal = false;
  late double weightDB;
  late double minGlucoseConcentration;
  late double maxGlucoseConcentration;

  TextEditingController weightController = TextEditingController();
  TextEditingController mlKgController = TextEditingController();
  TextEditingController restrictionController = TextEditingController();
  TextEditingController additionController = TextEditingController();
  TextEditingController feedingController = TextEditingController();
  TextEditingController drugsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    trophic = 30.0;
    maxGlucoseConcentration = 25;
    minGlucoseConcentration = 5;
  }

  void calculateNetVolume() {
    double weightValue = double.tryParse(weight) ?? 0;
    double mlKgValue = double.tryParse(mlKg) ?? 0;
    double restrictionValue = double.tryParse(restriction) ?? 0;
    double additionValue = double.tryParse(addition) ?? 0;
    double feedingValue = double.tryParse(feeding) ?? 0;

    double netVolume = (mlKgValue * weightValue) -
        restrictionValue +
        additionValue +
        feedingValue +
        (trophic * weightValue);
    setState(() {
      netVolumeResult = netVolume.toStringAsFixed(2);
    });
    //widget.onCalculate(weight, netVolumeResult);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextField(
                  label: "Trophic",
                  initialValue: trophic.toString(),
                  onChanged: (value) {
                    setState(() {
                      trophic = double.tryParse(value) ?? 0;
                    });
                    calculateNetVolume();
                  },
                ),
                const SizedBox(height: 20),
                MyTextField(
                  label: "Weight (Kg)",
                  thecontroller: weightController,
                  onChanged: (value) {
                    setState(() {
                      weight = value;
                    });
                    calculateNetVolume();
                  },
                ),
                const SizedBox(height: 20),
                MyTextField(
                    label: "ml/kg/day",
                    thecontroller: mlKgController,
                    onChanged: (value) {
                      setState(() {
                        weight = value;
                        calculateNetVolume();
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: mlKgController,
                      decoration: const InputDecoration(labelText: "ml/kg/day"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          mlKg = value;
                        });
                        calculateNetVolume();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: restrictionController,
                      decoration:
                          const InputDecoration(labelText: "Restriction"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          restriction = value;
                        });
                        calculateNetVolume();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: additionController,
                      decoration: const InputDecoration(labelText: "Addition"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          addition = value;
                        });
                        calculateNetVolume();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: feedingController,
                      decoration: const InputDecoration(labelText: "Feeding"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          feeding = value;
                        });
                        calculateNetVolume();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: drugsController,
                      decoration: const InputDecoration(labelText: "Drugs"),
                      onChanged: (value) {
                        setState(() {
                          drugs = value;
                        });
                        calculateNetVolume();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Enter Weight (Kg)'),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            weightDB = double.tryParse(value) ?? 0;
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showWeightModal = false;
                            });
                            calculateNetVolume();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
                setState(() {
                  showWeightModal = true;
                });
              },
              child: const Text("Calculate Net Volume"),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Net Volume: $netVolumeResult ml",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      trophic: trophic,
                      maxGlucoseConcentration: maxGlucoseConcentration,
                      minGlucoseConcentration: minGlucoseConcentration,
                      onSave: (trophic, minGlucoseConcentration,
                              maxGlucoseConcentration) =>
                          0,
                    ),
                  ),
                );
              },
              child: const Text("Settings"),
            ),
          ),
        ],
      ),
    );
  }
}
