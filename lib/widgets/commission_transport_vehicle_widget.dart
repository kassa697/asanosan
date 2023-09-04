import 'package:flutter/material.dart';
import 'package:car_go_bridge/widgets/commission_widgets.dart';

class CommissionTransportVehicleWidget extends StatefulWidget {
  final int itemCount;
  final List<Map> initialValue;
  final Function(int, Map<String, String>) onTextChanged;

  const CommissionTransportVehicleWidget({
    Key? key,
    required this.itemCount,
    required this.initialValue,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  State<CommissionTransportVehicleWidget> createState() =>
      _CommissionTransportVehicleWidgetState();
}

class _CommissionTransportVehicleWidgetState
    extends State<CommissionTransportVehicleWidget> {
  List<Map<String, TextEditingController>> _controllersList = [];

  void _updateController(int index, String key, String value) {
    widget.onTextChanged(index, {
      'name': _controllersList[index]['name']!.text,
      'color': _controllersList[index]['color']!.text,
      'note': _controllersList[index]['note']!.text,
    });
  }

//itemCountが増減した時の動作
  @override
  void didUpdateWidget(CommissionTransportVehicleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount) {
      if (widget.itemCount > oldWidget.itemCount) {
        for (int i = oldWidget.itemCount; i < widget.itemCount; i++) {
          var nameController = TextEditingController();
          var colorController = TextEditingController();
          var noteController = TextEditingController();
          nameController.addListener(() => _updateController(i, 'name', nameController.text));
          colorController.addListener(() => _updateController(i, 'color', colorController.text));
          noteController.addListener(() => _updateController(i, 'note', noteController.text));
          _controllersList.add({'name': nameController, 'color': colorController, 'note': noteController});
        }
      } else {
        for (int i = oldWidget.itemCount - 1; i >= widget.itemCount; i--) {
          for (var controller in _controllersList[i].values) {
            controller.dispose();
          }
          _controllersList.removeAt(i); // Remove it from the list
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //widget.itemCount の値に基づいて、指定された数のコントローラが _controllersList に追加される
    _controllersList = List.generate(
      widget.itemCount,
      (index) {
        var nameController = TextEditingController(text: widget.initialValue[index]['name']);
        var colorController = TextEditingController(text: widget.initialValue[index]['color']);
        var noteController = TextEditingController(text: widget.initialValue[index]['note']);
        
        nameController.addListener(() => _updateController(index, 'name', nameController.text));
        colorController.addListener(() => _updateController(index, 'color', colorController.text));
        noteController.addListener(() => _updateController(index, 'note', noteController.text));

        return {'name': nameController, 'color': colorController, 'note': noteController};
      },
    );
  }

  @override
  void dispose() {
    for (var controllers in _controllersList) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    child: Row(
      children: [
        Container(
            constraints: const BoxConstraints(minWidth: 70),
            child: const Text('輸送車両 : ')),
        const SizedBox(width: 8),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.itemCount,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    children: [
                      ExpandedTextField(
                        controller: _controllersList[index]['name']!,
                        hintText: '輸送車両: ${index + 1}',
                      ),
                      const SizedBox(width: 8),
                      ExpandedTextField(
                        controller: _controllersList[index]['color']!,
                        hintText: 'ボディカラー: ${index + 1}',
                      ),
                      const SizedBox(width: 8),
                      ExpandedTextField(
                        controller: _controllersList[index]['note']!,
                        hintText: '備考: ${index + 1}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Add vertical space
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}
    }
    