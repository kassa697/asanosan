import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final Function(bool)? onChanged;
  const MyCheckbox({super.key, 
this.onChanged,}) ;

    @override
  State<MyCheckbox> createState() =>
      _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool isChecked = false;
  
  

  @override
  Widget build(BuildContext context) {

    return Checkbox(
      value: isChecked,
      activeColor: Colors.blue,
      onChanged: (value) {
        setState(() {
          isChecked = value ?? false; // valueがnullの場合に備えてデフォルト値を設定
        });
        widget.onChanged!(value!);
      },
    );
  }
}
