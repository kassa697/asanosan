// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:car_go_bridge/screens/commission_list_dy.dart';
import 'package:car_go_bridge/screens/commission_list_dk.dart';
import 'package:car_go_bridge/screens/account_register.dart';
import 'package:car_go_bridge/utils/authentication.dart';
import 'package:car_go_bridge/utils/firestore/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[200], // bodyの背景色
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              child: Center(
                child: Column(
                  children: [
                    Column(
                      children: const [
                        Text(
                          "車両輸送手配システム",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "『Car Go Bridge』",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      height: 400,
                      margin: const EdgeInsets.only(top: 40),
                      constraints: const BoxConstraints(maxWidth: 450),
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'email',
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(),
                                hintText: '会社アドレスを入力してください',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              // keyboardType: TextInputType.visiblePassword,
                              controller: passController,
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              decoration: const InputDecoration(
                                
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'password',
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(),
                                hintText: '8桁〜16桁の英数字を入力してください',
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () async{
                                      var result = await Authentication.emailSignIn(email: emailController.text, pass: passController.text);
                                      if(result is UserCredential){ //resultがUserCredentialという型だったら
                                        var _result = await UserFirestore.getUser(result.user!.uid);
                                        if(_result != false &&_result.company == 'DK'){
                                            Navigator.pushReplacement(
                                              context, MaterialPageRoute(builder: (context) => const CommissionListDKPage()));
                                        }
                                        else{
                                        Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                        }
                                      }
                                    },
                                    child: const Text('DKログイン')),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async{
                                      var result = await Authentication.emailSignIn(email: emailController.text, pass: passController.text);
                                      if(result is UserCredential){ //resultがUserCredentialという型だったら
                                        var _result = await UserFirestore.getUser(result.user!.uid);
                                        if(_result != false &&_result.company == 'DY'){
                                            Navigator.pushReplacement(
                                              context, MaterialPageRoute(builder: (context) => const CommissionListDYPage()));
                                        }
                                        else{
                                        Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                        }
                                      }
                                    },
                                    child: const Text('DYログイン')),
                              ),
                            ),
                            
                          ),
                          const SizedBox(height: 10,),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(text: '新規登録は'),
                                TextSpan(text: 'こちら',
                                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline, ),
                                recognizer: TapGestureRecognizer()..onTap =(){
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const UserRegisterPage(),
                                  ),
                                  ); 
                                })
                              ]))
                        ],
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
  }
}
