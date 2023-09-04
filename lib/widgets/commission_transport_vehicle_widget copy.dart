import 'package:flutter/material.dart';
import 'package:car_go_bridge/widgets/commission_widgets.dart';

class CommissionTransportVehicleWidget extends StatefulWidget {
  final int itemCount;
  final Function(int, String) onTextChanged;
  // final Function(int, String) onTextColorChanged;
  // final Function(int, String) onTextNoteChanged;

  const CommissionTransportVehicleWidget({
    Key? key,
    required this.itemCount,
    required this.onTextChanged,
    // required this.onTextColorChanged,
    // required this.onTextNoteChanged,

  }) : super(key: key);

  @override
  State<CommissionTransportVehicleWidget> createState() =>
      _CommissionTransportVehicleWidgetState();
}

class _CommissionTransportVehicleWidgetState
    extends State<CommissionTransportVehicleWidget> {
  List<TextEditingController> _controllers = [];
  List<TextEditingController> _colorControllers = [];
  List<TextEditingController> _noteControllers = [];

  @override
  void didUpdateWidget(CommissionTransportVehicleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount) {
      if (widget.itemCount > oldWidget.itemCount) {
        for (int i = oldWidget.itemCount; i < widget.itemCount; i++) {
          var controller = TextEditingController();
          controller.addListener(() {
            widget.onTextChanged(i, controller.text);
          });
          _controllers.add(controller);

          // var colorController = TextEditingController();
          // colorController.addListener(() {
          //   print('カラーコントローラー');
          //   print(colorController.text);
          //   widget.onTextColorChanged(i, colorController.text);
          // });
          // _colorControllers.add(colorController);

          // var noteController = TextEditingController();
          // noteController.addListener(() {
          //   widget.onTextNoteChanged(i, noteController.text);
          // });
          // _noteControllers.add(noteController);
        }
      } else {
        for (int i = oldWidget.itemCount - 1; i >= widget.itemCount; i--) {
          _controllers[i].dispose();
          _controllers.removeAt(i); // Remove it from the list
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controllers = List<TextEditingController>.generate(
      widget.itemCount,
      (index) {
        var controller = TextEditingController();
        controller.addListener(() {
          widget.onTextChanged(index, controller.text);
        });
        return controller;
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_colorControllers);
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
                          controller: _controllers[index],
                          hintText: '輸送車両: ${index + 1}',
                        ),
                        const SizedBox(width: 8),
                        ExpandedTextField(
                          controller: TextEditingController(),
                          hintText: 'ボディカラー: ${index + 1}',
                        ),
                        const SizedBox(width: 8),
                        ExpandedTextField(
                          controller: TextEditingController(),
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
