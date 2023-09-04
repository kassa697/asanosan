import 'package:car_go_bridge/models/account.dart';
import 'package:car_go_bridge/models/commission_content.dart';
import 'package:car_go_bridge/screens/commission_list_dk.dart';
import 'package:car_go_bridge/utils/authentication.dart';
import 'package:car_go_bridge/widgets/custom_app_bar.dart';
import 'package:car_go_bridge/widgets/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_go_bridge/widgets/commission_widgets.dart';
import 'package:car_go_bridge/widgets/dino_status_widgets.dart';
import 'package:car_go_bridge/widgets/commission_transport_vehicle_widget.dart';
import 'package:car_go_bridge/widgets/commission_transport_route_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:car_go_bridge/utils/range_text_input_formatter.dart';

class CommissionPage extends StatefulWidget {
  final TransportOrder? copyOrder;
  const CommissionPage({super.key, this.copyOrder});

  @override
  State<CommissionPage> createState() => _CommissionPageState();
}

class _CommissionPageState extends State<CommissionPage> {
  String? selectedOption;
  String carNumber = '';
  bool isShoppingListChecked = false;
  List<String> transportVehicles = [];
  List<Map> transportVehiclesMap = [];
  Map<int, List<Widget>> transportRoutes = {};
  final NumberFormat formatter = NumberFormat('#,###');
  TextEditingController titleController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController estimatedAmountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  String? transportVehicleType;
  String? dinoStatus='見積照会(DK)';

  Future<void> createTransportOrder(
    currentUser,
    applicationDate,
    transportVehicleType,
  ) async {
    // final outputFormat = DateFormat('yyyy/MM/dd');
    final ordersCollection = FirebaseFirestore.instance.collection('orders').doc(CommissionUUIDWidgets.uuid);
    await ordersCollection.set({
      // 'uid' : CommissionUUIDWidgets.uuid,
      'applicationDate': Timestamp.now(),
      'applicant': currentUser,
      'applicantId':myAccount.id,
      // 'applicationDate': outputFormat.format(applicationDate),
      'title': titleController.text,
      'quantity': convertNumber(quantityController.text),
      'transportVehicleType': transportVehicleType,
      'transportVehicleModel':transportVehiclesMap,   //List(name, color, note)
      'departureLocation':'',
      'departureDate': Timestamp.now(),
      'departureStaff':'',
      'departureNotes':'',
      'arrivalLocation': '',
      'arrivalDate':Timestamp.now(),
      'arrivalStaff':'',
      'arrivalNotes':'',
      'transportRoute': '',
      'estimatedAmount': convertNumber(estimatedAmountController.text),
      'remarks': remarksController.text,
      'shoppingList':isShoppingListChecked,
      'dinoStatus': dinoStatus,
    });
  }

  int convertNumber(parameter){
    if (parameter.isNotEmpty) {
      try {
        return int.parse(parameter);
      } catch (e) { //仕様で0にしている
        return 0;
      }
    }
    return 0;
  }
//carNumberを数値に変更
  int _parseCarNumber() {
    if (carNumber.isNotEmpty) {
      try {
        return int.parse(carNumber);
      } catch (e) {
        return 1;
      }
    }
    return 1;
  }
  
  Account myAccount = Authentication.myAccount!;

  @override
  void initState() {
    super.initState();
    if (widget.copyOrder != null) {
      titleController.text = widget.copyOrder!.title;
      quantityController.text = widget.copyOrder!.quantity.toString();
      estimatedAmountController.text =
          widget.copyOrder!.estimatedAmount != null
      ? widget.copyOrder!.estimatedAmount.toString()
      : '';
      remarksController.text = widget.copyOrder!.remarks ?? '';
      transportVehiclesMap =widget.copyOrder!.transportVehicleModel;
      isShoppingListChecked =widget.copyOrder!.shoppingList;
      // see:
      // widget.copyOrderがnullでない場合のみ、setStateを実行する
      // 主に新規申請なので不要な処理かもしれない
      setState(() {
        carNumber = widget.copyOrder!.quantity.toString();
        transportVehicleType =widget.copyOrder!.transportVehicleType;
        transportVehicles = List.filled(widget.copyOrder!.transportVehicleModel.length, '',
            growable:
                true); //TODO parseCarNumberではなく、List.filledの第１引数にvalueを渡すのがベスト。
        transportRoutes = {
          for (var k in List.generate(_parseCarNumber(), (i) => i))
            k: [const CommissionTransportRouteWidget()]
        };
        // transportVehiclesMap = List.filled(_parseCarNumber(), {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final outputFormat = DateFormat('yyyy/MM/dd');
    String applicationDate = outputFormat.format(DateTime.now());
    String typeNumber = '2620-A200';
    String currentUser = myAccount.name; //
     print(transportVehiclesMap);
     print(transportVehicles);

    return Scaffold(
      appBar: const CustomAppBarDK(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue[100],
          width: double.infinity,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const CommissionTitleWidgets(title: '新規依頼ページ'),
                  CommissionSizedBoxWidgets(
                    textItems: [
                      '日付 : $applicationDate',
                      '申請者 : $currentUser',
                      '製番 : $typeNumber'
                    ],
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  CommissionUUIDWidgets(), //自動採番
                  CommissionRowPaddingWidget(
                    controller: titleController,
                    labelText: 'タイトル :',
                    hintText: 'タイトル',
                    isExpanded: true,
                  ),
                  CommissionRowPaddingWidget(
                    controller: quantityController,
                    labelText: '台数 :',
                    hintText: '台数（1〜10）',
                    suffixText: '台',
                    maxWidth: 100,
                    isExpanded: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 1, max: 10)
                    ],
                    onChanged: (value) {
                      setState(() {
                        // print(value);
                        carNumber = value;
                        transportVehicles = List.filled(_parseCarNumber(), '',
                            growable:
                                true); //TODO parseCarNumberではなく、List.filledの第１引数にvalueを渡すのがベスト。
                        transportRoutes = {
                          for (var k
                              in List.generate(_parseCarNumber(), (i) => i))
                            k: [const CommissionTransportRouteWidget()]
                        };
                        transportVehiclesMap = List.filled(_parseCarNumber(), {});
                      });
                    },
                  ),
                  CommissionDropdownWidget(
                    onChanged: (value) {
                      setState(() {
                        // print(value);
                        transportVehicleType = value;
                      });
                    },
                  ),
                  // 輸送車両欄
                  if (carNumber.isNotEmpty)
                    CommissionTransportVehicleWidget(
                      itemCount: _parseCarNumber(),
                      initialValue: transportVehiclesMap !=null
                      ? transportVehiclesMap
                      : [],
                      onTextChanged: (index, value) {
                        // print('index: $index, value: $value');
                        setState(() {
                          transportVehicles[index] = value['name'] as String;
                          if (index >= _parseCarNumber()) {
                              transportVehiclesMap.add(value);
                            } else {
                              transportVehiclesMap[index] = value;
                            }
                        });
                      },
                    ),
                  //輸送経路
                  if (carNumber.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transportVehicles.length,
                      itemBuilder: (context, index) {
                        // print(transportVehicles.length);
                        return Container(
                          color: index % 2 == 0
                              ? Colors.lightBlue[200]
                              : Colors.green[100],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('車種: ${transportVehicles[index]}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                              ...transportRoutes[index] ?? const <Widget>[],
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          transportRoutes[index]!.add(
                                              const CommissionTransportRouteWidget());
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      child: const Icon(Icons.add),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (transportRoutes[index]!.isNotEmpty) {
                                            transportRoutes[index]!.removeLast();
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      child: const Icon(Icons.remove),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  CommissionRowPaddingWidget(
                    controller: estimatedAmountController,
                    labelText: '見積金額 : ',
                    hintText: '見積金額',
                    suffixText: '円',
                    isExpanded: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  CommissionRowPaddingWidget(
                    controller: remarksController,
                    labelText: '備考 : ',
                    hintText: '備考',
                    isExpanded: true,
                    minLines: 10,
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // DINOステータス
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        color: Colors.lightBlue[100]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DINOCheckboxWidget(
                            labelText: 'DINOステータス : ',
                            checkboxText: 'shoppingList',
                            value: isShoppingListChecked,
                            onChanged: (newValue) {
                              setState(() {
                                isShoppingListChecked = newValue ?? false;
                              });
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DINOStatusWidgets(
                              isShoppingListChecked: isShoppingListChecked,
                            )),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if(int.parse(quantityController.text)  == transportVehiclesMap.length){
                          await createTransportOrder(
                            currentUser,
                            applicationDate,
                            transportVehicleType,
                          );
                          // ignore: use_build_context_synchronously
                          myDialog(context,'依頼が完了しました',() {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CommissionListDKPage(),
                                                ),
                                              );
                                            },);
                          }else {
                              myDialog(context, '台数と車種情報の数が合いません', () {
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text(
                          '依頼する',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}
