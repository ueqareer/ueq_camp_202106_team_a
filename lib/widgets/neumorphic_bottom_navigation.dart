import 'package:cordinate_sns_app/screens/screen4.dart';
import 'package:cordinate_sns_app/screens/screen5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cordinate_sns_app/widgets/image_for_toggle.dart';
import 'package:cordinate_sns_app/screens/screen3.dart';

class NeumorphicBottomNavigation extends StatefulWidget {
  const NeumorphicBottomNavigation({Key? key}) : super(key: key);

  @override
  _NeumorphicBottomNavigationState createState() =>
      _NeumorphicBottomNavigationState();
}

class _NeumorphicBottomNavigationState
    extends State<NeumorphicBottomNavigation> {
  int _selectedIndex = 0;

  void screenTransition(int selectedIndex) {
    if (selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Screen3(),
        ),
      );
    } else if (selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Screen4(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Screen5(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicToggle(
      height: 50,
      selectedIndex: _selectedIndex,
      displayForegroundOnlyIfSelected: true,
      thumb: Neumorphic(),
      children: [
        ToggleElement(
          background: ImageForToggle(
            imagePath: "images/home.png",
          ),
          foreground: ImageForToggle(
            imagePath: "images/home.png",
          ),
        ),
        ToggleElement(
          background: ImageForToggle(
            imagePath: "images/tshirt.png",
          ),
          foreground: ImageForToggle(
            imagePath: "images/tshirt.png",
          ),
        ),
        ToggleElement(
          background: ImageForToggle(
            imagePath: "images/recruitment.png",
          ),
          foreground: ImageForToggle(
            imagePath: "images/recruitment.png",
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedIndex = value;
          print(_selectedIndex);
          screenTransition(_selectedIndex);
        });
      },
    );
  }
}
