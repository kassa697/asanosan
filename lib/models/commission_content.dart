import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransportOrder {
  final Timestamp applicationDate;      // 申請日
  final String applicant;               // 申請者
  final String applicantId;             // 申請者ID

  final String orderId;                 // 注文ID
  final String title;                   // タイトル
  final int quantity;                   // 台数
  final String transportVehicleType;    // 輸送車種

  //TransportVehicle　輸送車両
  final List<Map<String, dynamic>> transportVehicleModel;
  // final String transportVehicleText;    // 輸送車両
  // final String bodyColor;               // ボディカラー
  // final String? modelNotes;             // 備考

  //TransportRoute　輸送経路
  final String transportRoute;          // 輸送経路
  final String departureLocation;       // 発場所
  final Timestamp? departureDate;       // 発日付
  final String? departureStaff;         // 発受入担当者
  final String? departureNotes;         // 発備考
  final String arrivalLocation;         // 着場所
  final Timestamp? arrivalDate;         // 着日付
  final String? arrivalStaff;           // 着受入担当者
  final String? arrivalNotes;           // 着備考

  final int? estimatedAmount;           // 見積金額
  final String? remarks;                // 備考

  //dinoStatus DINOステータス
  final bool shoppingList;              // ショッピングリスト
  final bool? dxSlEstimatedCheck;       // DKショッピングリスト見積照会
  final Timestamp? dxSlEstimatedDate;   // DKショッピングリスト見積照会期限
  final bool? dySlEstimatedcheck;       // DYショッピングリスト見積照会
  final Timestamp? dySlEstimatedDate;   // DYショッピングリスト見積照会期限
  final bool? dxSlPurchaseCheck;        // DKショッピングリスト購入要求
  final Timestamp? dxSlPurchaseDate;    // DKショッピングリスト購入要求期限
  final bool? dySlPurchaseCheck;        // DYショッピングリスト購入要求
  final Timestamp? dySlPurchaseDate;    // DYショッピングリスト購入要求期限  
  final bool? dxEstimatedCheck;         // DK見積照会
  final Timestamp? dxEstimatedDate;     // DK見積照会期限
  final bool? dyEstimatedcheck;         // DY見積照会
  final Timestamp? dyEstimatedDate;     // DY見積照会期限
  final bool? dxPurchaseCheck;          // DK購入要求
  final Timestamp? dxPurchaseDate;      // DK購入要求期限
  final bool? dyPurchaseCheck;          // DY購入要求
  final Timestamp? dyPurchaseDate;      // DY購入要求期限
  final bool? dxInspectionCheck;        // DK検収
  final Timestamp? dxInspectionDate;    // DK検収
  final String? assignedId1;            // 追加担当者ID 1
  final String? assigneeName1;          // 追加担当者名 1
  final String? assignedId2;            // 追加担当者ID 2
  final String? assigneeName2;          // 追加担当者名 2
  final String dinoStatus;              // DINOステータス

  TransportOrder({
    required this.applicationDate,      // 申請日
    required this.applicant,            // 申請者
    required this.applicantId,          // 申請者ID

    required this.orderId,
    required this.title,
    required this.quantity,
    required this.transportVehicleType,

    //TransportVehicle　輸送車両テキスト
    required this.transportVehicleModel,
    // required this.transportVehicleText,
    // required this.bodyColor,
    // this.modelNotes,

    //TransportRoute　輸送経路
     required this.transportRoute,
    required this.departureLocation,
    this.departureDate,
    this.departureStaff,
    this.departureNotes,
    required this.arrivalLocation,
    this.arrivalDate,
    this.arrivalStaff,
    this.arrivalNotes,

    this.estimatedAmount,
    this.remarks = '',
    
    //dinoStatus DINOステータス
    this.shoppingList=false,                  // ショッピングリスト
    this.dxSlEstimatedCheck,            // DKショッピングリスト見積照会
    this.dxSlEstimatedDate,             // DKショッピングリスト見積照会期限
    this.dySlEstimatedcheck,            // DYショッピングリスト見積照会
    this.dySlEstimatedDate,             // DYショッピングリスト見積照会期限
    this.dxSlPurchaseCheck,             // DKショッピングリスト購入要求
    this.dxSlPurchaseDate,              // DKショッピングリスト購入要求期限
    this.dySlPurchaseCheck,             // DYショッピングリスト購入要求
    this.dySlPurchaseDate,              // DYショッピングリスト購入要求期限  
    this.dxEstimatedCheck,              // DK見積照会
    this.dxEstimatedDate,               // DK見積照会期限
    this.dyEstimatedcheck,              // DY見積照会
    this.dyEstimatedDate,               // DY見積照会期限
    this.dxPurchaseCheck,               // DK購入要求
    this.dxPurchaseDate,                // DK購入要求期限
    this.dyPurchaseCheck,               // DY購入要求
    this.dyPurchaseDate,                // DY購入要求期限
    this.dxInspectionCheck,             // DK検収
    this.dxInspectionDate,              // DK検収
    this.assignedId1,                   // 追加担当者ID 1
    this.assigneeName1,                 // 追加担当者名 1
    this.assignedId2,                   // 追加担当者ID 2
    this.assigneeName2,                 // 追加担当者名 2
    required this.dinoStatus,                    // DINOステータス
  });
}
