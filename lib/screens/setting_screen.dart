import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final double trophic;

  final double minGlucoseConcentration;
  final double maxGlucoseConcentration;
  final void Function(
    double trophic,
    double minGlucoseConcentration,
    double maxGlucoseConcentration,
  ) onSave;

  const SettingsScreen({
    required this.trophic,
    required this.minGlucoseConcentration,
    required this.maxGlucoseConcentration,
    required this.onSave, // Add the onSave parameter here
  });
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _trophicController;
  late TextEditingController _minGlucoseConcentrationController;
  late TextEditingController _maxGlucoseConcentrationController;

  @override
  void initState() {
    super.initState();
    _trophicController = TextEditingController(text: widget.trophic.toString());
    _minGlucoseConcentrationController =
        TextEditingController(text: widget.minGlucoseConcentration.toString());
    _maxGlucoseConcentrationController =
        TextEditingController(text: widget.maxGlucoseConcentration.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _trophicController,
              decoration: const InputDecoration(labelText: 'Trophic'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _minGlucoseConcentrationController,
              decoration: const InputDecoration(
                  labelText: 'Minimum Glucose Concentration'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _maxGlucoseConcentrationController,
              decoration: const InputDecoration(
                  labelText: 'Maximum Glucose Concentration'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final trophic = double.tryParse(_trophicController.text) ?? 0;
                final minGlucoseConcentration =
                    double.tryParse(_minGlucoseConcentrationController.text) ??
                        0;
                final maxGlucoseConcentration =
                    double.tryParse(_maxGlucoseConcentrationController.text) ??
                        0;
                widget.onSave(
                    trophic, minGlucoseConcentration, maxGlucoseConcentration);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _trophicController.dispose();
    _minGlucoseConcentrationController.dispose();
    _maxGlucoseConcentrationController.dispose();
    super.dispose();
  }
}
