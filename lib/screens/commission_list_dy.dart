import 'package:bordered_text/bordered_text.dart';
import 'package:car_go_bridge/screens/account_edit.dart';
import 'package:car_go_bridge/screens/commission.dart';
import 'package:car_go_bridge/screens/commission_detail_dy.dart';
import 'package:car_go_bridge/screens/login.dart';
import 'package:car_go_bridge/utils/authentication.dart';
import 'package:car_go_bridge/widgets/checkbox.dart';
import 'package:car_go_bridge/widgets/custom_app_bar.dart';
import 'package:car_go_bridge/models/commission_content.dart';
import 'package:car_go_bridge/screens/commission_detail_dk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class CommissionListDYPage extends StatefulWidget {
  const CommissionListDYPage({super.key});

  @override
  State<CommissionListDYPage> createState() => _CommissionListDYPageState();
}

class _CommissionListDYPageState extends State<CommissionListDYPage> {
  final ordersCollection = FirebaseFirestore.instance.collection('orders');
  String addCommaToNum({required int num}){
    final formatter = intl.NumberFormat("#,###");
    String numWithComma = formatter.format(num);
    return numWithComma;
  }

  Future<void> deleteOrder(String orderId) async{
    final doc = FirebaseFirestore.instance.collection('orders').doc(orderId);
    await doc.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarDY(),
        backgroundColor: Colors.lightBlue[100], // bodyの背景色
        body: Container(
              padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const Text('ダイハツ輸送', style: TextStyle(
                  fontSize: 20
                ),
              ),
              
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100, 
                        child: const Text('担当者')),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100, 
                        child: const Text('依頼日')),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100, 
                        child: const Text('出発日')),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 120, 
                        child: const Text('輸送車両')),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 240, 
                        child: const Text('件名')),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 200, 
                        child: const Text('経路')),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 80, 
                        child: const Text('見積金額')),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: 120, 
                        child: const Text('DINOステータス')),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: ordersCollection
                    .where('dinoStatus',
                      whereIn: ['SL見積照会(DK)', 'SL見積照会(DY)','SL購入要求(DK)', 'SL購入要求(DY)','見積照会(DK)', '見積照会(DY)','購入要求(DK)', '購入要求(DY)','検収(DK)'])
                    .orderBy('applicationDate', descending: true)
                    .snapshots(),
                    builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }
                    if(!snapshot.hasData){
                      return const Center(child: Text('データがありません'),);
                    }
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      physics: const RangeMaintainingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = docs[index].data() as Map<String, dynamic>;
                        final TransportOrder fetchOrder = TransportOrder(
                          applicationDate: data['applicationDate'],
                          applicant: data['applicant'],
                          applicantId:data['applicantId'],

                          orderId: docs[index].id,
                          title: data['title'],
                          quantity: data['quantity'],
                          transportVehicleType: data['transportVehicleType'],

                          //TransportVehicle　輸送車両
                          transportVehicleModel: data['transportVehicleModel'],
                          // transportVehicleText: data['transportVehicleText'] ??'',
                          // bodyColor: data['bodyColor'],
                          // modelNotes: data['modelNotes'],

                          //TransportRoute　輸送経路
                          departureLocation:data['departureLocatio'],
                          departureDate: data['departureDate'] != null
                              ? data['statusDate']
                              : null,
                          departureStaff:data['departureStaff'],
                          departureNotes:data['departureNotes'],
                          arrivalLocation: data['arrivalLocation'],
                          arrivalDate: data['arrivalDate'] != null
                              ? data['statusDate']
                              : null,
                          arrivalStaff:data['arrivalStaff'],
                          arrivalNotes:data['arrivalNotes'],
                          transportRoute: data['transportRoute'],

                          estimatedAmount: data['estimatedAmount'] ??'',
                          remarks: data['remarks'],

                          shoppingList:data['shoppingList'],                      // ショッピングリスト
                          dxSlEstimatedCheck:data['dxSlEstimatedCheck']?? '',     // DKショッピングリスト見積照会
                          dxSlEstimatedDate:data['dxSlEstimatedDate']?? '',       // DKショッピングリスト見積照会期限
                          dySlEstimatedcheck:data['dySlEstimatedcheck'],          // DYショッピングリスト見積照会
                          dySlEstimatedDate:data['dySlEstimatedDate']?? '',       // DYショッピングリスト見積照会期限
                          dxSlPurchaseCheck:data['dxSlPurchaseCheck']?? '',       // DKショッピングリスト購入要求
                          dxSlPurchaseDate:data['dxSlPurchaseDate']?? '',         // DKショッピングリスト購入要求期限
                          dySlPurchaseCheck:data['dySlPurchaseCheck']?? '',       // DYショッピングリスト購入要求
                          dySlPurchaseDate:data['dySlPurchaseDate']?? '',         // DYショッピングリスト購入要求期限  
                          dxEstimatedCheck:data['dxEstimatedCheck']?? '',         // DK見積照会
                          dxEstimatedDate:data['dxEstimatedDate']?? '',           // DK見積照会期限
                          dyEstimatedcheck:data['dyEstimatedcheck']?? '',         // DY見積照会
                          dyEstimatedDate:data['dyEstimatedDate']?? '',           // DY見積照会期限
                          dxPurchaseCheck:data['dxPurchaseCheck']?? '',           // DK購入要求
                          dxPurchaseDate:data['dxPurchaseDate']?? '',             // DK購入要求期限
                          dyPurchaseCheck:data['dyPurchaseCheck']?? '',           // DY購入要求
                          dyPurchaseDate:data['dyPurchaseDate']?? '',             // DY購入要求期限
                          dxInspectionCheck:data['dxInspectionCheck']?? '',       // DK検収
                          dxInspectionDate:data['dxInspectionDate']?? '',         // DK検収
                          assignedId1:data['assignedId1']?? '',                   // 追加担当者ID 1
                          assigneeName1:data['assigneeName1']?? '',               // 追加担当者名 1
                          assignedId2:data['assignedId2']?? '',                   // 追加担当者ID 2
                          assigneeName2:data['assigneeName2']?? '',               // 追加担当者名 2
                          dinoStatus: data['dinoStatus'] ?? '',                   // DINOステータス
                        );
                        
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,MaterialPageRoute(
                                    builder: (context) => CommissionDetailDYPage(
                                          currentOrder: fetchOrder,
                                        )));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    child: Text(
                                      fetchOrder.applicant,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    child: Text(intl.DateFormat('yyyy.MM.dd')
                                          .format(fetchOrder.applicationDate.toDate()))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    child: fetchOrder.departureDate !=null ?
                                    Text(intl.DateFormat('yyyy.MM.dd')
                                          .format(fetchOrder.departureDate!.toDate()))
                                          :const Text('調整中')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 120, 
                                    child: Text(fetchOrder.transportVehicleModel.toString())),//輸送車両
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 240, 
                                    child: Text(fetchOrder.title)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 200, 
                                    child: const Text('経路')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: 80,
                                    child: Text(addCommaToNum(
                                      num: fetchOrder.estimatedAmount!.toInt())+ '円')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 120,
                                    child: Text(fetchOrder.dinoStatus)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                ),
              ),
            ],
          ),
        ),
        );
  }
}
