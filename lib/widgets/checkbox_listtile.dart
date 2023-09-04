import 'package:flutter/material.dart';

class MyCheckboxListTile extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final String text;

  const MyCheckboxListTile({
    required this.value,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Transform.translate(
        offset: const Offset(-20, 0),
        child: Text(text),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
