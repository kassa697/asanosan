import 'package:bordered_text/bordered_text.dart';
import 'package:car_go_bridge/models/account.dart';
import 'package:car_go_bridge/utils/authentication.dart';
import 'package:car_go_bridge/utils/firestore/users.dart';
import 'package:car_go_bridge/widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  String? selectedOption;
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Account myAccount = Account(
    id:'',
    name:'',
    userId:'',
    email:'',
    company:'',
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarLogin(),
      backgroundColor: Colors.lightBlue[200], // bodyの背景色
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Column(
                children: [
                  Text('新規登録', style: TextStyle(
                  fontSize: 20
                  ),),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('※全て必須項目', 
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: '名前',
                            border: OutlineInputBorder(),
                            hintText: '名前を入力してください',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: userIdController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'ID',
                            border: OutlineInputBorder(),
                            hintText: '社員番号（7桁）を入力してください',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(7),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: passController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'password',
                            border: OutlineInputBorder(),
                            hintText: '8桁〜16桁の英数字を入力してください',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          obscureText: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'mail address',
                            border: OutlineInputBorder(),
                            hintText: '会社のメールアドレスを入力してください',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(8),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          isExpanded: true,
                          value: selectedOption,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedOption = newValue;
                            });
                          },
                          items: <String>['DK', 'DY',]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: const Text('所属会社を選択してください'),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 50, 50, 30),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async{
                                  if(nameController.text.isNotEmpty
                                    && userIdController.text.isNotEmpty
                                    && passController.text.isNotEmpty
                                    && emailController.text.isNotEmpty
                                    && selectedOption !=null){
                                  var result = await Authentication.signUp(email: emailController.text, pass: passController.text);
                                  if(result is UserCredential){ //resultがUserCredentialという型だったら
                                    Account newAccount = Account(
                                      id: result.user!.uid, 
                                      name: nameController.text, 
                                      userId: userIdController.text, 
                                      email: emailController.text, 
                                      company: selectedOption.toString(),
                                      );
                                    var _result = await UserFirestore.setUser(newAccount);
                                    if(_result == true){
                                    Navigator.pop(context);
                                    }
                                  }
                                  }
                                },
                                child: const Text('アカウントを作成'),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(150),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 200),
                            child: SizedBox(
                              width: double.infinity,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () async{
                                    Navigator.pop(context);
                                },
                                child: const Text('キャンセル'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.black,
                                  fixedSize: Size.fromWidth(120),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
