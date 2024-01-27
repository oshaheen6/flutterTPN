import 'package:flutter/material.dart';

class Parameters extends StatefulWidget {
  final String weight;
  final String netVolume;
  final double? maxGlucoseConcentration;
  final double? minGlucoseConcentration;

  const Parameters({
    Key? key,
    required this.weight,
    required this.netVolume,
    this.maxGlucoseConcentration,
    this.minGlucoseConcentration,
  }) : super(key: key);

  @override
  _ParametersState createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  final TextEditingController _naController = TextEditingController();
  final TextEditingController _kController = TextEditingController();
  final TextEditingController _mgController = TextEditingController();
  final TextEditingController _phosphorusController = TextEditingController();
  final TextEditingController _traceElementController = TextEditingController();
  final TextEditingController _vitaminsController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _lipidController = TextEditingController();
  final TextEditingController _girController = TextEditingController();

  final List<FocusNode> _focusNodes = List.generate(9, (_) => FocusNode());

  double? _maxGir;
  double _naMl = 0;
  double _kMl = 0;
  double _mgMl = 0;
  double _phosphorusMl = 0;
  double _protienMl = 0;
  double _lipidMl = 0;
  double _vitaminMl = 0;
  double _traceMl = 0;
  String _naConcentration = '0.9%';
  String _traceElement = 'Addaven';
  double _glucosePercentage = 0;

  late double weight;
  late double netVolume;

  @override
  void initState() {
    super.initState();
    weight =
        double.tryParse(widget.weight.replaceAll(RegExp(r'[^\d\.]'), '')) ?? 0;
    netVolume =
        double.tryParse(widget.netVolume.replaceAll(RegExp(r'[^\d\.]'), '')) ??
            0;
  }

  @override
  void dispose() {
    _naController.dispose();
    _kController.dispose();
    _mgController.dispose();
    _phosphorusController.dispose();
    _traceElementController.dispose();
    _vitaminsController.dispose();
    _proteinController.dispose();
    _lipidController.dispose();
    _girController.dispose();

    for (var node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void _calculateMaxGir() {
    // Calculate max GIR based on the input values
    double na = double.tryParse(_naController.text) ?? 0;
    double k = double.tryParse(_kController.text) ?? 0;
    double mg = double.tryParse(_mgController.text) ?? 0;
    double phosphorus = double.tryParse(_phosphorusController.text) ?? 0;
    double traceElement = double.tryParse(_traceElementController.text) ?? 0;
    double vitamins = double.tryParse(_vitaminsController.text) ?? 0;
    double protein = double.tryParse(_proteinController.text) ?? 0;
    double lipid = double.tryParse(_lipidController.text) ?? 0;

    _phosphorusMl = phosphorus * 1;
    var naPhosphorus = phosphorus * 2;

    _naMl =
        (na - naPhosphorus) * weight * (_naConcentration == '0.9%' ? 6.5 : 2);

    _kMl = k * weight * 0.5;
    _mgMl = mg * weight * 2.5;

    _lipidMl = lipid * weight * 5;
    _protienMl = protein * weight * 10;
    _vitaminMl = vitamins * weight;
    _traceMl = traceElement * weight * (_traceElement == 'Addaven' ? 0.1 : 1);

    double glucoseVolume = netVolume -
        (_lipidMl +
            _protienMl +
            _naMl +
            _kMl +
            _mgMl +
            _phosphorusMl +
            _traceMl +
            _vitaminMl);
    double calculatedMaxGir =
        glucoseVolume / 24 * 25 / (6 * weight) * (1 + _glucosePercentage / 100);

    setState(() {
      _maxGir = calculatedMaxGir;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildParameterField(
            'Na',
            _naController,
            _focusNodes[0],
            _changeFocus,
            TextInputType.number,
            DropdownButton<String>(
              value: _naConcentration,
              onChanged: (String? value) {
                setState(() {
                  _naConcentration = value!;
                });
              },
              items: <String>['0.9%', '3%']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )),
        _buildParameterField('K', _kController, _focusNodes[1], _changeFocus,
            TextInputType.number),
        _buildParameterField('Mg', _mgController, _focusNodes[2], _changeFocus,
            TextInputType.number),
        _buildParameterField('Phosphorus', _phosphorusController,
            _focusNodes[3], _changeFocus, TextInputType.number),
        _buildParameterField(
            'Trace element',
            _traceElementController,
            _focusNodes[4],
            _changeFocus,
            TextInputType.number,
            DropdownButton<String>(
              value: _traceElement,
              onChanged: (String? value) {
                setState(() {
                  _traceElement = value!;
                });
              },
              items: <String>['Addaven', 'Peditrace']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )),
        _buildParameterField('Vitamins', _vitaminsController, _focusNodes[5],
            _changeFocus, TextInputType.number),
        _buildParameterField('Protein', _proteinController, _focusNodes[6],
            _changeFocus, TextInputType.number),
        _buildParameterField('Lipid', _lipidController, _focusNodes[7],
            _changeFocus, TextInputType.number),
        const Divider(height: 20, thickness: 2),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'GIR & Max GIR',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: DropdownButton<double>(
                              value: _glucosePercentage,
                              onChanged: (double? value) {
                                setState(() {
                                  _glucosePercentage = value!;
                                });
                              },
                              items: <double>[
                                0,
                                5,
                                10,
                                25
                              ].map<DropdownMenuItem<double>>((double value) {
                                return DropdownMenuItem<double>(
                                  value: value,
                                  child: Text('$value%'),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _girController,
                              focusNode: _focusNodes[8],
                              decoration: InputDecoration(
                                hintText: 'GIR',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (_) => _calculateMaxGir(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _maxGir != null
                            ? 'Max GIR: ${_maxGir!.toStringAsFixed(2)} mg/kg/min'
                            : '',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _changeFocus(int index) {
    if (index + 1 < _focusNodes.length) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  Widget _buildParameterField(
      String label,
      TextEditingController controller,
      FocusNode focusNode,
      void Function(int) onSubmitted,
      TextInputType keyboardType,
      [Widget? trailing]) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffix: trailing,
      ),
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      onChanged: (_) => _calculateMaxGir(),
      onSubmitted: (_) => onSubmitted(_focusNodes.indexOf(focusNode)),
    );
  }
}

class MaxGIRCalculator extends StatelessWidget {
  const MaxGIRCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Max GIR Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text("Weight: ${widget.weight}"),
            // Text("Net Volume: ${widget.netVolume}"),
            const Parameters(
              weight: '80 kg',
              netVolume: '1500 ml',
              maxGlucoseConcentration: 25,
              minGlucoseConcentration: null,
            ),
          ],
        ),
      ),
    );
  }
}
