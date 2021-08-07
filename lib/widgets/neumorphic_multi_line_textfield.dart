import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicMultiLineTextField extends StatefulWidget {
  String hint;

  final ValueChanged<String> onChanged;

  NeumorphicMultiLineTextField({required this.hint, required this.onChanged});

  @override
  _NeumorphicMultiLineTextFieldState createState() =>
      _NeumorphicMultiLineTextFieldState();
}

class _NeumorphicMultiLineTextFieldState
    extends State<NeumorphicMultiLineTextField> {
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
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 20),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: SizedBox(
            height: 90,
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              onChanged: (value) {
                print(value);
              },
              controller: _controller,
              decoration: InputDecoration.collapsed(hintText: this.widget.hint),
            ),
          ),
        )
      ],
    );
  }
}
