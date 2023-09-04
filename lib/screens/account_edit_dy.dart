import 'package:car_go_bridge/models/account.dart';
import 'package:car_go_bridge/screens/login.dart';
import 'package:car_go_bridge/utils/authentication.dart';
import 'package:car_go_bridge/utils/firestore/users.dart';
import 'package:car_go_bridge/widgets/custom_app_bar.dart';
import 'package:car_go_bridge/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserEditDYPage extends StatefulWidget {
  const UserEditDYPage({super.key});

  @override
  State<UserEditDYPage> createState() => _UserEditDYPageState();
}

class _UserEditDYPageState extends State<UserEditDYPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Account myAccount = Authentication.myAccount!;

  @override
  void initState(){
    super.initState();
    nameController = TextEditingController(text: myAccount.name);
    userIdController = TextEditingController(text: myAccount.userId);
    emailController = TextEditingController(text: myAccount.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarDY(),
      backgroundColor: Colors.lightBlue[200], 
       body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Column(
                children: [
                  const Text('プロフィール編集', style: TextStyle(
                  fontSize: 20
                  ),),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
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
                          decoration: const InputDecoration(
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
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'mail address',
                            border: OutlineInputBorder(),
                            hintText: '会社のメールアドレスを入力してください',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 40, 50, 30),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async{
                                  if(nameController.text.isNotEmpty
                                    && userIdController.text.isNotEmpty
                                    && passController.text.isNotEmpty
                                    && emailController.text.isNotEmpty){
                                      Account updateAccount = Account(
                                        id: myAccount.id, 
                                        name: nameController.text, 
                                        userId: userIdController.text, 
                                        email: emailController.text,);
                                      Authentication.myAccount = updateAccount;
                                      var result = await UserFirestore.updateUser(updateAccount);
                                      if(result == true){
                                        Navigator.pop(context, true);
                                      }
                                    }
                                    myDialog(context, '更新が完了しました', 
                                      () {
                                        Navigator.pop(context, true);
                                        Navigator.pop(context, true); });
                                },
                                child: const Text('更新'),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromWidth(150),
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
                                  myDialog(context, 'アカウントを削除します', 
                                    () {
                                      UserFirestore.deleteUser(myAccount.id);
                                      Authentication.deleteAuth();
                                      while(Navigator.canPop(context)){
                                        Navigator.pop(context);
                                      }
                                      Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => const LoginPage())); });
                                    },
                                child: const Text('アカウント削除'),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromWidth(100),
                                  primary: Colors.red
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