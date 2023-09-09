
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendData {
  const SendData({
    required this.testController,
    required this.testController2,
    required this.testController3,
    required this.testController4,
    required this.testController5,
    required this.testController6,
    required this.testController7,
    required this.testController8,
});
  // テキストフィールドのcontrollerを定義
  final TextEditingController testController;
  final TextEditingController testController2;
  final TextEditingController testController3;
  final TextEditingController testController4;
  final TextEditingController testController5;
  final TextEditingController testController6;
  final TextEditingController testController7;
  final TextEditingController testController8;
  // 以下の所は今回は使わないが書いておくと後々便利なので書いておきます。
  SendData copyWith ({
    TextEditingController? testController,
    TextEditingController? testController2,
    TextEditingController? testController3,
    TextEditingController? testController4,
    TextEditingController? testController5,
    TextEditingController? testController6,
    TextEditingController? testController7,
    TextEditingController? testController8,
}) {
    return SendData(
      testController: testController ?? this.testController,
      testController2: testController2 ?? this.testController2,
      testController3: testController3 ?? this.testController3,
      testController4: testController4 ?? this.testController4,
      testController5: testController5 ?? this.testController5,
      testController6: testController6 ?? this.testController6,
      testController7: testController7 ?? this.testController7,
      testController8: testController8 ?? this.testController8,
    );
  }
}


// 状態管理で作成したクラスを実際に活用するコードの所です。
class SendNotifier extends StateNotifier<SendData> {
  SendNotifier() : super(SendData(
    // クラスが呼ばれたときに初期化するコードです。
    // 今回はテキストフィールドのコントローラーに空の文字列を渡して初期化しています。
    testController: TextEditingController(text: ''),
    testController2: TextEditingController(text: ''),
    testController3: TextEditingController(text: ''),
    testController4: TextEditingController(text: ''),
    testController5: TextEditingController(text: ''),
    testController6: TextEditingController(text: ''),
    testController7: TextEditingController(text: ''),
    testController8: TextEditingController(text: ''),
  ));
}

// 以下の分が重要な所、「sendProvider」を利用して
// 他のプログラムファイルで今回のクラスで作成した物を使用することができます。
final sendProvider = StateNotifierProvider<SendNotifier, SendData>((ref) => SendNotifier());