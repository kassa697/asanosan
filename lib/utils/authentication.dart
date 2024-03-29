import 'package:car_go_bridge/models/account.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

//新規登録
  static Future<dynamic> signUp({
    required String email,
    required String pass,
  }) async {
    try {
      UserCredential newAccount =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print('auth登録完了');
      return newAccount;
    } on FirebaseAuthException catch (e) {
      print('auth登録エラー $e');
      return false;
    }
  }

//ログイン
  static Future<dynamic> emailSignIn({
    required String email,
    required String pass,
  }) async {
    try {
      final UserCredential _result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = _result.user;
      print(_result.user?.uid);
      print('authサインイン完了');
      return _result;
    } on FirebaseAuthException catch (e) {
      print('authサインインエラー $e');
      return false;
    }
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  static Future<void> deleteAuth() async {
    await currentFirebaseUser!.delete();
  }

  // 認証状態の確認
  static Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}
