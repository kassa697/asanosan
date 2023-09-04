import 'package:firebase_auth/firebase_auth.dart';

import '../models/account.dart';
import './authentication.dart';
import './firestore/users.dart';

class UserService {
  // ユーザー login状態の確認
  static Stream<Account?> authStateCurrentUser() {
    return Authentication.authStateChanges().asyncMap((User? user) async {
      if (user == null) {
        print('未ログイン');
        return null;
      }
      try {
        await UserFirestore.getUser(user.uid);
        return Authentication.myAccount;
      } catch (e) {
        print('ユーザー取得エラー： $e');
        return null;
      }
    });
  }
}
