import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_appbar.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_textfield.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_text_for_textfield.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_button.dart';

class CreateAccountScreen extends StatelessWidget {
  Function createAccount = () {
    print("アカウント作成");
  };

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
        home: SafeArea(
      child: Scaffold(
        appBar: NeumorphicCustomAppBar(
          title: "Create Account Page",
          fontSize: 30.0,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Neumorphic(
                  padding: EdgeInsets.all(30),
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: NeumorphicTheme.embossDepth(context),
                  ),
                  child: Image(
                    image: AssetImage("images/user.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: NeumorphicText(
                  "プロフィール画像を選択",
                  style: NeumorphicStyle(color: Colors.black54),
                  textStyle: NeumorphicTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
              NeumorphicTextForTextField(
                text: "ユーザ名を入力してください",
                color: Colors.black54,
              ),
              NeumorphicTextField(
                isPassword: false,
                hint: "",
                onChanged: (lastName) {},
              ),
              NeumorphicTextForTextField(
                text: "メールアドレスを入力してください",
                color: Colors.black54,
              ),
              NeumorphicTextField(
                isPassword: false,
                hint: "",
                onChanged: (mail) {},
              ),
              NeumorphicTextForTextField(
                text: "パスワードを入力してください",
                color: Colors.black54,
              ),
              NeumorphicTextField(
                isPassword: true,
                hint: "",
                onChanged: (password) {},
              ),
              NeumorphicTextForTextField(
                text: "確認用パスワードを入力してください",
                color: Colors.black54,
              ),
              NeumorphicTextField(
                isPassword: true,
                hint: "",
                onChanged: (reconfirmPassword) {},
              ),
              NeumorphicCustomButton(
                text: "アカウント作成",
                color: Colors.black54,
                onPressed: createAccount,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
