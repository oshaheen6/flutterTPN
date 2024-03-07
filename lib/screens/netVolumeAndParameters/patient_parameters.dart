import 'package:flutter/material.dart';
import 'package:flutter_split_view/flutter_split_view.dart';
import 'netvolume_screen.dart';
import 'parameters.dart';

class PatientParametersScreen extends StatefulWidget {
  @override
  _PatientParametersScreenState createState() =>
      _PatientParametersScreenState();
}

class _PatientParametersScreenState extends State<PatientParametersScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SplitView.material(
        placeholder: PlaceholderPage(),
        child: MainPage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Net Volume'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NetVolumeCalculator(),
            ElevatedButton(
              child: const Text('click'),
              onPressed: () {
                SplitView.of(context).setSecondary(
                  SecondPage(weight: weight, netVolume: netVolume),
                  title: 'Parameters',
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

  const SecondPage({
    Key? key,
    required this.weight,
    required this.netVolume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parameters'),
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
                  const SizedBox(height: 16),
                  Parameters(
                    weight: weight,
                    netVolume: netVolume,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('forward'),
                    onPressed: () {
                      //upload.addingDailyParameters(RequestParameter(netVolume: NetVolume(patient: Patient(patientName: patientName, docId: docId, mrn: mrn)), date: date, sodiumRequired: sodiumRequired, potassiumRequired: potassiumRequired, girRequired: girRequired, proteinRequired: proteinRequired, lipidRequired: lipidRequired))
                      SplitView.of(context).push(
                        const ThirdPage(),
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
