import 'package:flutter/material.dart';
import 'package:car_go_bridge/widgets/checkbox.dart';
import 'package:car_go_bridge/widgets/dropdown.dart';

class DateInputField extends StatefulWidget {
  const DateInputField({super.key});

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        );

        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
              hintText: selectedDate != null
                  ? "${selectedDate!.year}/${selectedDate!.month}/${selectedDate!.day}"
                  : "日付を選択してください"),
        ),
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  final String label;

  const CustomTextWidget({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MyCustomRow extends StatelessWidget {
  final String label;
  final bool isSecondElementVisible;

  const MyCustomRow({
    Key? key,
    required this.label,
    this.isSecondElementVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth *
              0.8, // Set the width to 80% of the parent widget
          child: Padding(
            padding: const EdgeInsets.all(8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomTextWidget(label: label),
              Flex(
                direction: Axis.horizontal,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text('宣伝室期限'),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        MyCheckbox(),
                        const Expanded(flex: 2, child: DateInputField()),
                      ],
                    ),
                  ),
                ],
              ),
              if (isSecondElementVisible) ...[
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text('ダイハツ輸送期限'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          MyCheckbox(),
                          const Expanded(flex: 2, child: DateInputField()),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ]),
          ),
        );
      },
    );
  }
}

class MyCustomDropdownRow extends StatelessWidget {
  final String label;

  const MyCustomDropdownRow({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth *
              0.8, // Set the width to 80% of the parent widget
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(label: label),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('宣伝室'),
                    ),
                    Expanded(
                      flex: 3,
                      child: MyDropdownMenu(),
                    ),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('宣伝室'),
                    ),
                    Expanded(
                      flex: 3,
                      child: MyDropdownMenu(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DINOStatusWidgets extends StatelessWidget {
  final bool isShoppingListChecked;

  const DINOStatusWidgets({
    Key? key,
    required this.isShoppingListChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isShoppingListChecked) ...[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 10),
            MyCustomRow(
              label: 'shopping list見積',
            ),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              MyCustomRow(
                label: 'shopping list内示発注',
              ),
            ],
          ),
        ],
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          MyCustomRow(label: '見積照会'),
        ]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            MyCustomRow(label: '購入要求'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            MyCustomRow(label: '検収', isSecondElementVisible: false),
          ],
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20),
          MyCustomDropdownRow(label: '担当者追加'),
        ]),
        const SizedBox(height: 10),
      ],
    );
  }
}

class DINOCheckboxWidget extends StatefulWidget {
  final String labelText;
  final String checkboxText;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const DINOCheckboxWidget({
    Key? key,
    required this.labelText,
    required this.checkboxText,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DINOCheckboxWidget> createState() => _DINOCheckboxWidgetState();
}

class _DINOCheckboxWidgetState extends State<DINOCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 0, 8),
          child: Container(
            constraints: const BoxConstraints(minWidth: 60),
            child: Text(
              widget.labelText,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Row(
            children: [
              Checkbox(
                value: widget.value,
                onChanged: widget.onChanged,
              ),
              Text(widget.checkboxText),
            ],
          ),
        ),
      ],
    );
  }
}
