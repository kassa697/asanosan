import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String id; //ユーザーを特定するためのID firebaseに登録していくためのもの 
  String name;
  String userId; //社員番号
  String email;
  String? company; 
  Timestamp? createdTime;
  Timestamp? updatedTime;

  Account({
    required this.id,
    required this.name,
    required this.userId,
    required this.email,
    this.company,
    this.createdTime,
    this.updatedTime,
  });
}
