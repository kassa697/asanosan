import 'package:flutter/material.dart';
import 'package:car_go_bridge/widgets/commission_widgets.dart';

// 輸送経路
class CommissionTransportRouteWidget extends StatefulWidget {
  const CommissionTransportRouteWidget({Key? key}) : super(key: key);

  @override
  State<CommissionTransportRouteWidget> createState() =>
      _CommissionTransportRouteWidgetState();
}

class _CommissionTransportRouteWidgetState
    extends State<CommissionTransportRouteWidget> {
  late final TextEditingController _departurePlaceController;
  late final TextEditingController _departureUnreadableController;
  late final TextEditingController _departurePersonInChargeController;
  late final TextEditingController _departureRemarksController;

  late final TextEditingController _arrivalPlaceController;
  late final TextEditingController _arrivalUnreadableController;
  late final TextEditingController _arrivalPersonInChargeController;
  late final TextEditingController _arrivalRemarksController;

  @override
  void initState() {
    super.initState();
    _departurePlaceController = TextEditingController();
    _departureUnreadableController = TextEditingController();
    _departurePersonInChargeController = TextEditingController();
    _departureRemarksController = TextEditingController();

    _arrivalPlaceController = TextEditingController();
    _arrivalUnreadableController = TextEditingController();
    _arrivalPersonInChargeController = TextEditingController();
    _arrivalRemarksController = TextEditingController();
  }

  @override
  void dispose() {
    _departurePlaceController.dispose();
    _departureUnreadableController.dispose();
    _departurePersonInChargeController.dispose();
    _departureRemarksController.dispose();

    _arrivalPlaceController.dispose();
    _arrivalUnreadableController.dispose();
    _arrivalPersonInChargeController.dispose();
    _arrivalRemarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // 発
        children: [
          const Text('輸送経路 : '),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('発: '),
              ExpandedTextField(
                controller: _departurePlaceController,
                hintText: '場所',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: _departureUnreadableController,
                hintText: '日時',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: _departurePersonInChargeController,
                hintText: '受入担当者',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: _departureRemarksController,
                hintText: '備考',
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 着
          Row(
            children: [
              const Text('着: '),
              ExpandedTextField(
                controller: _arrivalPlaceController,
                hintText: '場所',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: _arrivalUnreadableController,
                hintText: '日時',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: _arrivalPersonInChargeController,
                hintText: '受入担当者',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: _arrivalRemarksController,
                hintText: '備考',
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
