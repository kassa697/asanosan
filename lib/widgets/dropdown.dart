import 'package:flutter/material.dart';

//TODO ユーザーリストから持って来られるようにする
const List<String> list = <String>['淺野', '鈴木', '小島', '石川', '虫明', '田島', '水谷', '長谷川', '櫻井'];

class MyDropdownMenu extends StatefulWidget {
  const MyDropdownMenu({super.key});

  @override
  State<MyDropdownMenu> createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        width: 180,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
          value: dropdownValue,
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value, style: TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
