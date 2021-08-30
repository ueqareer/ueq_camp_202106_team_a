import 'package:flutter/material.dart';
import 'package:cordinate_sns_app/screens/screen2.dart';
import 'package:cordinate_sns_app/screens/list_of_my_coordination_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_appbar.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_card.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_bottom_navigation.dart';

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  String getUidOfCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return "";
    } else {
      String uid = user.uid;
      return uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: NeumorphicCustomAppBar(
          title: "Coordinate App",
          fontSize: 30.0,
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/add_coordination.png",
                  text: "コーディネート一覧",
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListOfMyCoordinationScreen(
                        uid: getUidOfCurrentUser(),
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/tshirt.png",
                  text: "服一覧",
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Screen2(),
                    ),
                  );
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
