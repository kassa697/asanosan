import 'package:car_go_bridge/provider/trans.dart';
import 'package:flutter/material.dart';
import 'package:car_go_bridge/widgets/commission_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 輸送経路
class CommissionTransportRouteWidget extends ConsumerStatefulWidget {
  const CommissionTransportRouteWidget({Key? key}) : super(key: key);

  @override
  CommissionTransportRouteWidgetState createState() =>
      CommissionTransportRouteWidgetState();
}

class CommissionTransportRouteWidgetState
    extends ConsumerState<CommissionTransportRouteWidget> {


  @override
  Widget build(BuildContext context) {
    final sendData = ref.watch(sendProvider);
    final autoDisposeProvider = Provider.autoDispose((ref) {
      ref.onDispose(() {
        // このProviderが使用されなくなった＝破棄される直前に実行されます
      });
    });
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
                controller: sendData.testController,
                hintText: '場所',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: sendData.testController2,
                hintText: '日時',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: sendData.testController3,
                hintText: '受入担当者',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: sendData.testController4,
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
                controller: sendData.testController5,
                hintText: '場所',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: sendData.testController6,
                hintText: '日時',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: sendData.testController7,
                hintText: '受入担当者',
              ),
              const SizedBox(width: 8),
              ExpandedTextField(
                controller: sendData.testController8,
                hintText: '備考',
              ),
              ElevatedButton(onPressed: () {
              }, child: const Text('出力確認'))
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}


// late final TextEditingController _departurePlaceController;
// late final TextEditingController _departureUnreadableController;
// late final TextEditingController _departurePersonInChargeController;
// late final TextEditingController _departureRemarksController;
//
// late final TextEditingController _arrivalPlaceController;
// late final TextEditingController _arrivalUnreadableController;
// late final TextEditingController _arrivalPersonInChargeController;
// late final TextEditingController _arrivalRemarksController;
//
// @override
// void initState() {
//   super.initState();
//   _departurePlaceController = TextEditingController();
//   _departureUnreadableController = TextEditingController();
//   _departurePersonInChargeController = TextEditingController();
//   _departureRemarksController = TextEditingController();
//
//   _arrivalPlaceController = TextEditingController();
//   _arrivalUnreadableController = TextEditingController();
//   _arrivalPersonInChargeController = TextEditingController();
//   _arrivalRemarksController = TextEditingController();
// }
//
// @override
// void dispose() {
//   _departurePlaceController.dispose();
//   _departureUnreadableController.dispose();
//   _departurePersonInChargeController.dispose();
//   _departureRemarksController.dispose();
//
//   _arrivalPlaceController.dispose();
//   _arrivalUnreadableController.dispose();
//   _arrivalPersonInChargeController.dispose();
//   _arrivalRemarksController.dispose();
//   super.dispose();
// }