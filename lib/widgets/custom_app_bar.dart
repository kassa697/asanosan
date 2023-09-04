import 'package:bordered_text/bordered_text.dart';
import 'package:car_go_bridge/screens/account_edit.dart';
import 'package:car_go_bridge/screens/commission.dart';
import 'package:car_go_bridge/screens/commission_list_dk.dart';
import 'package:car_go_bridge/screens/commission_list_dy.dart';
import 'package:car_go_bridge/screens/login.dart';
import 'package:car_go_bridge/utils/authentication.dart';
import 'package:car_go_bridge/widgets/commission_widgets.dart';
import 'package:flutter/material.dart';

// Appbarのclassは、DK・DY・Nologinの３パターンある
class CustomAppBarDK extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarDK({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<CustomAppBarDK> createState() => _CustomAppBarDKState();
}

class _CustomAppBarDKState extends State<CustomAppBarDK> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      leadingWidth: 250,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('車両輸送手配システム'),
          BorderedText(
            strokeWidth: 1.0, //縁の太さ
            strokeColor: Colors.orange,
            child: const Text(
              'Car Go Bridge',
              style: TextStyle(
                fontSize: 33,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CommissionListDKPage(),
                ),
              );
            },
            style: TextButton.styleFrom(
              fixedSize: const Size(100, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // 角丸
              ),
            ).merge(
              ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    Color? color = Colors.white;

                    if (states.contains(MaterialState.hovered)) {
                      color = Colors.white;
                    }
                    if (states.contains(MaterialState.pressed)) {
                      color = Color.lerp(color, Colors.black, 0.5);
                    }
                    return color;
                  }),
                backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    Color? color = Colors.transparent;

                    if (states.contains(MaterialState.hovered)) {
                      color = Color.fromARGB(65, 255, 255, 255);
                    }
                    if (states.contains(MaterialState.pressed)) {
                      color = Color.lerp(color, Colors.black, 0.5);
                    }
                    return color;
                  }),
                ),
              ),
            child: const Text(
              'HOME',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 70,
          ),
          TextButton(
            onPressed: () {
              CommissionUUIDWidgets.uuid = null;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CommissionPage(),
                ),
              );
            },
            style: TextButton.styleFrom(
              fixedSize: const Size(120, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // 角丸
              ),
            ).merge(
              ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    Color? color = Colors.white;

                    if (states.contains(MaterialState.hovered)) {
                      color = Colors.white;
                    }
                    if (states.contains(MaterialState.pressed)) {
                      color = Color.lerp(color, Colors.black, 0.5);
                    }
                    return color;
                  }),
                backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    Color? color = Colors.transparent;

                    if (states.contains(MaterialState.hovered)) {
                      color = Color.fromARGB(65, 255, 255, 255);
                    }
                    if (states.contains(MaterialState.pressed)) {
                      color = Color.lerp(color, Colors.black, 0.5);
                    }
                    return color;
                  }),
                ),
              ),
            child: const Text(
              '新規依頼',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 70,
          ),
          PopupMenuButton(
            icon: const Icon(Icons.account_circle_outlined),
            iconSize: 30,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'page1',
                  child: Text('登録情報変更'),
                ),
                const PopupMenuItem(
                  value: 'page2',
                  child: Text('ログアウト'),
                ),
              ];
            },
            onSelected: (value) async{
              if (value == 'page1') {
                var result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserEditPage(
                    ),
                  ),
                );
              } else if (value == 'page2') { 
                  Authentication.signOut();
                  while(Navigator.canPop(context)){
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const LoginPage()));
              }
            },
            offset: const Offset(0, 40), // Y軸方向に40ポイント下げる
          )
        ],
      ),
      actions: const [
        SizedBox(
          width: 50,
        )
      ],
    );
  }
}

class CustomAppBarDY extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarDY({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<CustomAppBarDY> createState() => _CustomAppBarDYState();
}

class _CustomAppBarDYState extends State<CustomAppBarDY> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      leadingWidth: 250,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('車両輸送手配システム'),
          BorderedText(
            strokeWidth: 1.0, //縁の太さ
            strokeColor: Colors.orange,
            child: const Text(
              'Car Go Bridge',
              style: TextStyle(
                fontSize: 33,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CommissionListDYPage(),
                ),
              );
            },
            style: TextButton.styleFrom(
              fixedSize: const Size(100, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // 角丸
              ),
            ).merge(
              ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    Color? color = Colors.white;

                    if (states.contains(MaterialState.hovered)) {
                      color = Colors.white;
                    }
                    if (states.contains(MaterialState.pressed)) {
                      color = Color.lerp(color, Colors.black, 0.5);
                    }
                    return color;
                  }),
                backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    Color? color = Colors.transparent;

                    if (states.contains(MaterialState.hovered)) {
                      color = const Color.fromARGB(65, 255, 255, 255);
                    }
                    if (states.contains(MaterialState.pressed)) {
                      color = Color.lerp(color, Colors.black, 0.5);
                    }
                    return color;
                  }),
                ),
              ),
            child: const Text(
              'HOME',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 70,
          ),
          PopupMenuButton(
            icon: const Icon(Icons.account_circle_outlined),
            iconSize: 30,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'page1',
                  child: Text('登録情報変更'),
                ),
                const PopupMenuItem(
                  value: 'page2',
                  child: Text('ログアウト'),
                ),
              ];
            },
            onSelected: (value) async{
              if (value == 'page1') {
                var result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserEditPage(
                    ),
                  ),
                );
              } else if (value == 'page2') { 
                  Authentication.signOut();
                  while(Navigator.canPop(context)){
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const LoginPage()));
              }
            },
            offset: const Offset(0, 40), // Y軸方向に40ポイント下げる
          )
        ],
      ),
      actions: const [
        SizedBox(
          width: 50,
        )
      ],
    );
  }
}

class CustomAppBarLogin extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarLogin({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<CustomAppBarLogin> createState() => _CustomAppBarLoginState();
}

class _CustomAppBarLoginState extends State<CustomAppBarLogin> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('車両輸送手配システム'),
          BorderedText(
            strokeWidth: 1.0, //縁の太さ
            strokeColor: Colors.orange,
            child: const Text(
              'Car Go Bridge',
              style: TextStyle(
                fontSize: 33,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
