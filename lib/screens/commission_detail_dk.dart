import 'package:car_go_bridge/models/commission_content.dart';
import 'package:car_go_bridge/screens/commission_list_dk.dart';
import 'package:car_go_bridge/utils/range_text_input_formatter.dart';
import 'package:car_go_bridge/widgets/commission_transport_route_widget.dart';
import 'package:car_go_bridge/widgets/commission_transport_vehicle_widget.dart';
import 'package:car_go_bridge/widgets/commission_widgets.dart';
import 'package:car_go_bridge/widgets/custom_app_bar.dart';
import 'package:car_go_bridge/widgets/dialog.dart';
import 'package:car_go_bridge/widgets/dino_status_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CommissionDetailDKPage extends StatefulWidget {
  // final TransportOrder orderlist;
  final TransportOrder currentOrder;
  const CommissionDetailDKPage( {super.key, required this.currentOrder,});
  @override
  State<CommissionDetailDKPage> createState() => _CommissionDetailDKPageState();
}

class _CommissionDetailDKPageState extends State<CommissionDetailDKPage> {
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
  List<Map<String, TextEditingController>> _controllersList = [];
  
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

  Future<void> updateOrder() async{
    final doc = FirebaseFirestore.instance.collection('orders').doc(widget.currentOrder.orderId);
    await doc.update({
      'title': titleController.text,
      'quantity': int.parse(quantityController.text),
      'transportVehicleType':transportVehicleType,
      'transportVehicleModel':transportVehiclesMap,   //List(name, color, note)
      // 'departureLocation':'',
      'departureDate': Timestamp.now(),
      // 'departureStaff':'',
      // 'departureNotes':'',
      // 'arrivalLocation': '',
      'arrivalDate':Timestamp.now(),
      // 'arrivalStaff':'',
      // 'arrivalNotes':'',
      // 'transportRoute': '',
      'estimatedAmount': int.parse(estimatedAmountController.text),
      'remarks': remarksController.text,
      'shoppingList':isShoppingListChecked,
      'dinoStatus': dinoStatus,
    });
  }

   @override
  void initState(){
    super.initState();
      titleController.text= widget.currentOrder.title;
      quantityController.text= widget.currentOrder.quantity.toString();
      estimatedAmountController.text= 
        widget.currentOrder.estimatedAmount != null
        ? widget.currentOrder.estimatedAmount.toString()
        : '';
      remarksController.text= widget.currentOrder.remarks ?? '';
      transportVehiclesMap =widget.currentOrder.transportVehicleModel;
      isShoppingListChecked =widget.currentOrder.shoppingList;
    setState(() {
      carNumber = widget.currentOrder.quantity.toString();
      transportVehicleType =widget.currentOrder.transportVehicleType;
      transportVehicles =List.filled(widget.currentOrder.transportVehicleModel.length, '', 
        growable: true); //TODO parseCarNumberではなく、List.filledの第１引数にvalueを渡すのがベスト。　
      
      transportRoutes = {
        for (var k
              in List.generate(_parseCarNumber(), (i) => i))
              k: [const CommissionTransportRouteWidget()]
      };
    });
    
  
    // setState(() {
  //     for (int i = 0; i < int.parse(carNumber); i++) {
  //   var nameController = TextEditingController(text: transportVehiclesMap[i]['name${i + 1}']);
  //   var colorController = TextEditingController(text: transportVehiclesMap[i]['color${i + 1}']);
  //   var noteController = TextEditingController(text: transportVehiclesMap[i]['note${i + 1}']);
  //   transportVehiclesMap.add(nameController as Map);
  //   transportVehiclesMap.add(colorController as Map);
  //   transportVehiclesMap.add(noteController as Map);
  // }
    // });
  }
  

  @override
  Widget build(BuildContext context) {
    final outputFormat = DateFormat('yyyy/MM/dd');
    String applicationDate = outputFormat.format(widget.currentOrder.applicationDate.toDate());
    String typeNumber = '2620-A200';
    String applicant = widget.currentOrder.applicant; 

  print(transportVehiclesMap);
  print('aaaa');
  // print(transportVehiclesMap.runtimeType);

    return Scaffold(
      appBar: const CustomAppBarDK(),
      body: SingleChildScrollView(
        child: Container(
          color:  Colors.lightBlue[100],
          width: double.infinity,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const CommissionTitleWidgets(title: '依頼詳細ページ'),
                  CommissionSizedBoxWidgets(
                    textItems: [
                      '日付 : $applicationDate',
                      '申請者 : $applicant',
                      '製番 : $typeNumber'
                    ],
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  CommissionUUIDWidgets(orderid: widget.currentOrder.orderId,),
                  CommissionRowPaddingWidget(
                    controller: titleController,
                    labelText: 'タイトル :',
                    hintText: 'タイトル',
                    isExpanded: true,
                    // initialValue: widget.currentOrder!.title,
                  ),
                  CommissionRowPaddingWidget(
                    controller: quantityController,
                    labelText: '台数 :',
                    hintText: '台数（1〜10）',
                    suffixText: '台',
                    // initialValue: widget.currentOrder!.quantity.toString(),
                    maxWidth: 100,
                    isExpanded: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 1, max: 10)
                    ],
                    onChanged: (value) {
                      setState(() {
                        carNumber = value;
                        transportVehicles =
                            List.filled(_parseCarNumber(), '', growable: true);
                        transportRoutes = {
                          for (var k
                              in List.generate(_parseCarNumber(), (i) => i))
                            k: [const CommissionTransportRouteWidget()]
                        };
                      });
                    },
                  ),
                  CommissionDropdownWidget(
                    value: widget.currentOrder.transportVehicleType,
                  ),
                  //輸送車両
                  if (carNumber.isNotEmpty)
                    CommissionTransportVehicleWidget(
                      itemCount: _parseCarNumber(),  //widget.currentOrder.transportVehicleModel.lengthにすると表示されるが、CarNumberの数値を変更しても反映されなくなる
                      initialValue:transportVehiclesMap,
                      onTextChanged: (index, value) {
                        // print('index: $index, value: $value');
                        setState(() {
                          transportVehicles[index] = value['name'] as String;
                          if (index >= transportVehiclesMap.length) {
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
                      itemCount: _parseCarNumber(),
                      itemBuilder: (context, index) {
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
                    // initialValue: widget.currentOrder!.estimatedAmount.toString(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  CommissionRowPaddingWidget(
                    controller: remarksController,
                    labelText: '備考 : ',
                    hintText: '備考',
                    isExpanded: true,
                    // initialValue: widget.currentOrder!.remarks,
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
                        minimumSize: Size(150, 70),
                        shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                        ),
                        onPressed: () async{
                          if(int.parse(quantityController.text)  == transportVehiclesMap.length){
                          await updateOrder();
                          // ignore: use_build_context_synchronously
                          myDialog(context, '更新が完了しました', 
                            () {
                              Navigator.pop(context);
                              Navigator.pop(context); });
                          }else {
                              myDialog(context, '台数と車種情報の数が合いません', () {
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text('更新する', style: TextStyle(fontSize: 20),),
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

