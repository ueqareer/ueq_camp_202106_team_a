import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
                },
                child: Text(
                  'アカウント作成',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent,
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

class NeumorphicTextField extends StatefulWidget {
  String label;
  String hint;

  final ValueChanged<String> onChanged;

  NeumorphicTextField(
      {required this.label, required this.hint, required this.onChanged});

  @override
  _NeumorphicTextFieldState createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 8),
          child: Text(
            this.widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextField(
            onChanged: this.widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: this.widget.hint),
          ),
        )
      ],
    );
  }
}
