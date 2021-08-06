import 'package:cordinate_sns_app/screens/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_textfield.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NeumorphicTextField(
            label: 'ユーザ名を入力してください',
            hint: '',
            onChanged: (lastName) {},
          ),
          NeumorphicTextField(
            label: 'パスワード入力してください',
            hint: '',
            onChanged: (password) {},
          ),
          NeumorphicButton(
            child: Text(
              'ログイン',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              print('ログイン');
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'アカウントをお持ちでない場合は',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('アカウント作成画面に遷移');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateAccountScreen()),
                  );
                },
                child: Text(
                  'アカウント作成',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent.shade700,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
