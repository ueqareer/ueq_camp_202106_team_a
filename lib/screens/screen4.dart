import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_card.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_bottom_navigation.dart';

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: NeumorphicText(
            "Coordinate App",
            textStyle: NeumorphicTextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
            style: NeumorphicStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/coordination.png",
                  text: "コーディネート一覧",
                ),
                onTap: () {
                  print("select coordination");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/tshirt.png",
                  text: "服一覧",
                ),
                onTap: () {
                  print("select clothes");
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: NeumorphicBottomNavigation(),
      ),
    );
  }
}
