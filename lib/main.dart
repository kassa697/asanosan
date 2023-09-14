import 'package:car_go_bridge/firebase_options.dart';
import 'package:car_go_bridge/models/account.dart';
import 'package:car_go_bridge/screens/commission_list_dk.dart';
import 'package:car_go_bridge/screens/commission_list_dy.dart';
import 'package:car_go_bridge/screens/login.dart';
import 'package:car_go_bridge/utils/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Go Bridge',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlue,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        bottomAppBarTheme:
            const BottomAppBarTheme(color: Colors.lightBlue, height: 50),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.blue,
        ),
      ),
      home: StreamBuilder<Account?>(
        stream: UserService.authStateCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // スプラッシュ画面などに書き換えても良い
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final Account currentUser = snapshot.data!;
            if (currentUser.company == 'DK') {
              // DK用のホーム画面へ
              return const CommissionListDKPage();
            }
            if (currentUser.company == 'DY') {
              // DY用のホーム画面へ
              return const CommissionListDYPage();
            }
            // DK用でもDY用でもない場合はLogin画面へ
            return const LoginPage();
          }
          // User が null である、つまり未サインインのサインイン画面へ
          return const LoginPage();
        },
      ),
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => const HomeDKPage(title: '',),
      //   '/second':(BuildContext context) => const HomeDKPage(title: '',),
      // },
    );
  }
}
