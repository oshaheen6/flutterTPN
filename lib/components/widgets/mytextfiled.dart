import "package:flutter/material.dart";

// by default the TextInputType is number
class MyTextField extends StatelessWidget {
  final String label;
  final TextEditingController? thecontroller;
  final String? initialValue;
  final TextInputType keyboardType;
  final Function(String) onChanged;

  const MyTextField(
      {required this.label,
      this.thecontroller,
      this.initialValue,
      this.keyboardType = TextInputType.number,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: 250,
        child: TextField(
          decoration: InputDecoration(labelText: label),
          controller: thecontroller,
          keyboardType: keyboardType,
          onChanged: (value) {
            onChanged;
          },
        ),
      ),
    );
  }
}

// call onchange from cubit
//controller also
