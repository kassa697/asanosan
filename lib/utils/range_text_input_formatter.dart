import 'package:flutter/services.dart';

class RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final int? potentialNumber = int.tryParse(newValue.text);
    if (potentialNumber == null ||
        potentialNumber < min ||
        potentialNumber > max) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}
