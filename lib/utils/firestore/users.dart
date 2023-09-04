import 'package:car_go_bridge/models/account.dart';
import 'package:car_go_bridge/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserFirestore{
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _firestoreInstance.collection('users');

  static Future<dynamic>  setUser(Account newAccount) async{
    try{
      await users.doc(newAccount.id).set({
        'name': newAccount.name,
        'userId': newAccount.userId,
        'email': newAccount.email,
        'company': newAccount.company,
        'createdtime':Timestamp.now(),
        'updatedtime':Timestamp.now(),
      });
      print('新規ユーザー作成完了');
      return true;
    } on FirebaseException catch(e){
      print('新規ユーザー作成エラー: $e');
      return false;
    }
  }

  static Future<dynamic> getUser(String uid) async{
    try{
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
        id: uid, 
        name: data['name'], 
        userId: data['userId'], 
        email: data['email'], 
        company: data['company']);
      Authentication.myAccount = myAccount;
      print('ユーザー取得完了');
      return myAccount;
    } on FirebaseException catch(e){
      print('ユーザー取得エラー： $e');
      return false;
    } catch(e){
      print('不明エラー： $e');
      return false;
    }

  }

  static Future<dynamic> updateUser(Account updateAccount) async{
    try{
      await users.doc(updateAccount.id).update({
        'name':updateAccount.name,
        'userId':updateAccount.userId,
        'email':updateAccount.email,
        'updatedTime': Timestamp.now(),
      });
      print('ユーザー情報の更新完了');
      return true;
    } on FirebaseException catch(e){
      print('ユーザー取得エラー： $e');
      return false;
    }
  }

  static Future<dynamic> deleteUser(String accountId) async{
    await users.doc(accountId).delete();
  }
}
