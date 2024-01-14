import 'package:flutter/material.dart';
import 'package:flutter_split_view/flutter_split_view.dart';
import 'netvolume_screen.dart';
import 'parameters.dart';

class PatientParametersWeb extends StatefulWidget {
  @override
  _PatientParametersScreenState createState() =>
      _PatientParametersScreenState();
}

class _PatientParametersScreenState extends State<PatientParametersWeb> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SplitView.material(
        child: MainPage(),
        placeholder: PlaceholderPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String weight = "";
  String netVolume = "";
  double maxGlucoseConcentration = 0;
  double minGlucoseConcentration = 0;

  void _updateWeightAndNetVolume(String newWeight, String newNetVolume) {
    setState(() {
      weight = newWeight;
      netVolume = newNetVolume;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NetVolumeCalculator(onCalculate: _updateWeightAndNetVolume),
            ElevatedButton(
              child: const Text('click'),
              onPressed: () {
                SplitView.of(context).setSecondary(
                  SecondPage(
                    weight: weight,
                    netVolume: netVolume,
                    maxGlucoseConcentration: maxGlucoseConcentration,
                    minGlucoseConcentration: minGlucoseConcentration,
                  ),
                  title: 'Second',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String weight;
  final String netVolume;
  final double maxGlucoseConcentration;
  final double minGlucoseConcentration;

  const SecondPage({
    Key? key,
    required this.weight,
    required this.netVolume,
    required this.maxGlucoseConcentration,
    required this.minGlucoseConcentration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second'),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    child: const Text('back'),
                    onPressed: () {
                      SplitView.of(context).pop();
                    },
                  ),
                  SizedBox(height: 16),
                  Parameters(
                    weight: weight,
                    netVolume: netVolume,
                    maxGlucoseConcentration: maxGlucoseConcentration,
                    minGlucoseConcentration: minGlucoseConcentration,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('forward'),
                    onPressed: () {
                      SplitView.of(context).push(
                        ThirdPage(),
                        title: 'Third',
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third'),
      ),
      body: Center(
        child: Builder(builder: (context) {
          return ElevatedButton(
            child: const Text('back'),
            onPressed: () {
              SplitView.of(context).pop();
            },
          );
        }),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
// backgroundColor: Colors.ba
      body: Center(
        child: Text(
          'Click the button in main view to push to here',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
