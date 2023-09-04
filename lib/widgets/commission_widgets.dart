import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class CommissionTitleWidgets extends StatelessWidget {
  const CommissionTitleWidgets({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class CommissionUUIDWidgets extends StatelessWidget {
  const CommissionUUIDWidgets({Key? key ,this.orderid}) : super(key: key);

  // static final String uuid = const Uuid().v4();
    final String? orderid;
    static String? uuid;

  @override
  Widget build(BuildContext context) {
    //orderid 
     if(orderid == null && uuid == null){
         uuid = const Uuid().v4();
       }else if(orderid != null){
       uuid = orderid;
     }else /*if(orderid == null && uuid != null)*/{
       uuid = uuid;
     }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Row(children: [
          Container(
            constraints: const BoxConstraints(minWidth: 70),
            child: const Text("番号:"),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
                width: double.infinity,
                height: 40,
                child: Text(
                  uuid!,
                  style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
          ),
        ]));
  }
}

class CommissionSizedBoxWidgets extends StatelessWidget {
  final List<String> textItems;
  final CrossAxisAlignment crossAxisAlignment;

  const CommissionSizedBoxWidgets({
    super.key,
    required this.textItems,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: textItems
            .map((text) => Text(text, textAlign: TextAlign.start))
            .toList(),
      ),
    );
  }
}

class CommissionRowPaddingWidget extends StatefulWidget {
  final String labelText;
  final bool isExpanded;
  final double? maxWidth;
  final Function(String)? onChanged;
  final String hintText;
  final String suffixText;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines;
  final int? maxLines;
  final TextInputType keyboardType;
  final String? initialValue;
  TextEditingController? controller;

  CommissionRowPaddingWidget({
    super.key,
    required this.labelText,
    this.isExpanded = false,
    this.maxWidth,
    this.onChanged,
    this.hintText = '',
    this.suffixText = '',
    this.inputFormatters,
    this.minLines,
    this.maxLines,
    this.keyboardType = TextInputType.text,
    this.initialValue ='',
    this.controller,
  });

  @override
  State<CommissionRowPaddingWidget> createState() =>
      _CommissionRowPaddingWidgetState();
}

class _CommissionRowPaddingWidgetState
    extends State<CommissionRowPaddingWidget> {
  final FocusNode _focusNode = FocusNode();
  String _currentValue = '';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      widget.onChanged?.call(_currentValue);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
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
            child: Text(widget.labelText),
          ),
          const SizedBox(width: 8),
          if (widget.isExpanded)
            Expanded(
              child: buildTextField(),
            )
          else
            Container(
              constraints: BoxConstraints(
                maxWidth: widget.maxWidth ?? double.infinity,
              ),
              child: buildTextField(),
            ),
          if (widget.suffixText.isNotEmpty)
            Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.suffixText,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
        ],
      ),
    );
  }

  SizedBox buildTextField() {
    return SizedBox(
      width: double.infinity,
      height: widget.labelText == '備考 : ' ? 100 : 48,
      child: TextField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        keyboardType: widget.keyboardType,
        focusNode: _focusNode,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
          hintText: widget.hintText,
        ),
        onChanged: (value) {
          _currentValue = value;
        },
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}

class CommissionDropdownWidget extends StatefulWidget {
  final String? value;
  final Function(String)? onChanged;
  const CommissionDropdownWidget({
    super.key,
    // Key? key, 
    this.onChanged,
    this.value,  //valueを受け取って
  }) ;

  @override
  State<CommissionDropdownWidget> createState() =>
      _CommissionDropdownWidgetState();
}


class _CommissionDropdownWidgetState extends State<CommissionDropdownWidget> {
  String? selectedOption;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 70),
            child: const Text('輸送車 : '),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8),
                fillColor: Colors.white,
                filled: true,
              ),
              isExpanded: true,
              value: widget.value,
              //selectedOption,//? if文
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                });
                widget.onChanged!(newValue!);
              },
              items: <String>['パネルトラック', '幌車', '通常車', 'その他']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text('輸送車を選択してください'),
            ),
          ),
          if (selectedOption == 'その他')
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                    hintText: '詳細を入力してください',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ExpandedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function(String)? onChanged;

  const ExpandedTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
