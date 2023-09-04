import 'package:car_go_bridge/screens/commission.dart';
import 'package:car_go_bridge/widgets/checkbox.dart';
import 'package:car_go_bridge/widgets/commission_widgets.dart';
import 'package:car_go_bridge/widgets/custom_app_bar.dart';
import 'package:car_go_bridge/models/commission_content.dart';
import 'package:car_go_bridge/screens/commission_detail_dk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class CommissionListDKPage extends StatefulWidget {
  const CommissionListDKPage({super.key});

  @override
  State<CommissionListDKPage> createState() => _CommissionListDKPageState();
}

class _CommissionListDKPageState extends State<CommissionListDKPage> {
  final ordersCollection = FirebaseFirestore.instance.collection('orders');
  bool isChecked = false;
  String addCommaToNum({required int num}){
    final formatter = intl.NumberFormat("#,###");
    String numWithComma = formatter.format(num);
    return numWithComma;
  }

  Future<void> deleteOrder(String orderId) async {
    final doc = FirebaseFirestore.instance.collection('orders').doc(orderId);
    await doc.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarDK(),
      backgroundColor: Colors.lightBlue[100], // bodyの背景色
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text(
              'ダイハツ工業',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyCheckbox(
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
                const Text('過去の申請も表示'),
              ],
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
                      width: 40, 
                      child: const Text('台数')),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Container(
                      alignment: Alignment.center,
                      width: 200, 
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
                  stream: isChecked
                      ? ordersCollection
                          .orderBy('applicationDate', descending: true)
                          .snapshots()
                      : ordersCollection
                          .where('dinoStatus',
                              whereIn: ['SL見積照会(DK)', 'SL見積照会(DY)','SL購入要求(DK)', 'SL購入要求(DY)','見積照会(DK)', '見積照会(DY)','購入要求(DK)', '購入要求(DY)','検収(DK)'])
                          .orderBy('applicationDate', descending: true)
                          .snapshots(),
                  builder: (context, snapshot) {
                    // print(isChecked);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No data'),
                      );
                    }
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      physics: const RangeMaintainingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        print(docs[0].data());
                        print(docs[0].data().runtimeType);
                        
                        Map<String, dynamic> data =
                            docs[index].data() as Map<String, dynamic>;
                        print(data['transportVehicleModel']);
                        print('uuuuuuuuuu');
                        print(data['quantity'].runtimeType);
                        print(data['transportVehicleModel'][0]);

                        final TransportOrder fetchOrder = TransportOrder(
                          applicationDate: data['applicationDate'],
                          applicant: data['applicant'] ??'',
                          applicantId:data['applicantId'] ??'',

                          orderId: docs[index].id,
                          title: data['title'] ??'',
                          quantity: data['quantity'] ??'',
                          transportVehicleType: data['transportVehicleType'] ??'',

                          //TransportVehicle　輸送車両
                          transportVehicleModel: List<Map<String, dynamic>>.from(data['transportVehicleModel']),
                          // transportVehicleText: data['transportVehicleText'],
                          // bodyColor: data['bodyColor'],
                          // modelNotes: data['modelNotes']??'',

                          //TransportRoute　輸送経路
                          departureLocation:data['departureLocation'] ??'',
                          // departureDate: data['departureDate'],
                          departureDate: data['departureDate'] != null
                              ? data['departureDate']
                              : null,
                          departureStaff:data['departureStaff']??'',
                          departureNotes:data['departureNotes']??'',
                          arrivalLocation: data['arrivalLocation'] ??'',
                          arrivalDate: data['arrivalDate'] != null
                              ? data['arrivalDate']
                              : null,
                          arrivalStaff:data['arrivalStaff'],
                          arrivalNotes:data['arrivalNotes'],
                          transportRoute: data['transportRoute'] ??'',

                          estimatedAmount: data['estimatedAmount'],
                          remarks: data['remarks'] ??'',

                          shoppingList:data['shoppingList'],                      // ショッピングリスト
                          // dxSlEstimatedCheck:data['dxSlEstimatedCheck'],     // DKショッピングリスト見積照会
                          // dxSlEstimatedDate:data['dxSlEstimatedDate'],       // DKショッピングリスト見積照会期限
                          // dySlEstimatedcheck:data['dySlEstimatedcheck'],          // DYショッピングリスト見積照会
                          // dySlEstimatedDate:data['dySlEstimatedDate'],       // DYショッピングリスト見積照会期限
                          // dxSlPurchaseCheck:data['dxSlPurchaseCheck'],       // DKショッピングリスト購入要求
                          // dxSlPurchaseDate:data['dxSlPurchaseDate'],         // DKショッピングリスト購入要求期限
                          // dySlPurchaseCheck:data['dySlPurchaseCheck'],       // DYショッピングリスト購入要求
                          // dySlPurchaseDate:data['dySlPurchaseDate'],         // DYショッピングリスト購入要求期限  
                          // dxEstimatedCheck:data['dxEstimatedCheck'],         // DK見積照会
                          // dxEstimatedDate:data['dxEstimatedDate'],           // DK見積照会期限
                          // dyEstimatedcheck:data['dyEstimatedcheck'],         // DY見積照会
                          // dyEstimatedDate:data['dyEstimatedDate'],           // DY見積照会期限
                          // dxPurchaseCheck:data['dxPurchaseCheck'],           // DK購入要求
                          // dxPurchaseDate:data['dxPurchaseDate'],             // DK購入要求期限
                          // dyPurchaseCheck:data['dyPurchaseCheck'],           // DY購入要求
                          // dyPurchaseDate:data['dyPurchaseDate'],             // DY購入要求期限
                          // dxInspectionCheck:data['dxInspectionCheck'],       // DK検収
                          // dxInspectionDate:data['dxInspectionDate'],         // DK検収
                          // assignedId1:data['assignedId1'],                   // 追加担当者ID 1
                          // assigneeName1:data['assigneeName1'],               // 追加担当者名 1
                          // assignedId2:data['assignedId2'],                   // 追加担当者ID 2
                          // assigneeName2:data['assigneeName2'],               // 追加担当者名 2
                          dinoStatus: data['dinoStatus'] ??'',                   // DINOステータス
                        );

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommissionDetailDKPage(
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
                                    child: fetchOrder.departureDate != null
                                          ? Text(intl.DateFormat('yyyy.MM.dd')
                                              .format(
                                                  fetchOrder.departureDate!.toDate()))
                                          : const Text('調整中')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child:Container(
                                    alignment: Alignment.center,
                                    width: 120, 
                                    child: Text(fetchOrder.transportVehicleModel[0]['name'].toString())),//輸送車両
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 40,
                                    child: Text('${fetchOrder.quantity}台')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 200,
                                    child: Text(fetchOrder.title)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child:Container(
                                    alignment: Alignment.center,
                                    width: 200, 
                                    child: Text(fetchOrder.transportRoute)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: 80,
                                    child: Text(addCommaToNum(
                                        num: fetchOrder.estimatedAmount!.toInt()) + '円')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 120,
                                    child: Text(fetchOrder.dinoStatus)),
                                ),
                                const Expanded(child: SizedBox()),
                                IconButton(
                                  onPressed: () {
                                    CommissionUUIDWidgets.uuid = null;
                                    showGeneralDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      barrierLabel: '',
                                      transitionDuration:
                                          const Duration(milliseconds: 300),
                                      pageBuilder: (ctx, anim1, anim2) =>
                                          const SizedBox(),
                                      transitionBuilder:
                                          (ctx, anim1, anim2, child) =>
                                              Transform.scale(
                                        scale: anim1.value,
                                        child: Opacity(
                                          opacity: anim1.value,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Dialog(
                                              backgroundColor: Colors.white,
                                              child: Container(
                                                width: 50,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  children: [
                                                    const Text(
                                                      'コピーして新規依頼',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 10),
                                                    Center(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          Navigator.of(
                                                                  context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      CommissionPage(
                                                                copyOrder:
                                                                    fetchOrder,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.orange,
                                                        ),
                                                        child:
                                                            const Text('OK'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.content_copy),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: IconButton(
                                    onPressed: () {
                                      showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        barrierLabel: '',
                                        transitionDuration:
                                            const Duration(milliseconds: 300),
                                        pageBuilder: (ctx, anim1, anim2) =>
                                            const SizedBox(),
                                        transitionBuilder:
                                            (ctx, anim1, anim2, child) =>
                                                Transform.scale(
                                          scale: anim1.value,
                                          child: Opacity(
                                            opacity: anim1.value,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Dialog(
                                                backgroundColor: Colors.white,
                                                child: Container(
                                                  width: 50,
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        '依頼を削除',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Center(
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            await deleteOrder(
                                                                fetchOrder
                                                                    .orderId);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.orange,
                                                          ),
                                                          child:
                                                              const Text('OK'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete_forever),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)), // 縁取りの角丸の半径を設定
          side: BorderSide(color: Colors.blue, width: 2), // 縁取りの色と幅を設定
        ),
        onPressed: () {
          CommissionUUIDWidgets.uuid = null;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CommissionPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.blue,
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}
