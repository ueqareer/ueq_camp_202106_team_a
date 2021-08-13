import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_appbar.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_card.dart';


class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicCustomAppBar(
        title: "Coordinate App",
        fontSize: 30.0,
      ),
      body: Column(children: [
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/leather-jacket.png",
                  text: "ジャケット/アウター",
                ),
                onTap: () {
                  print("ジャケット/アウター");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/tshirt.png",
                  text: "トップス",
                ),
                onTap: () {
                  print("トップス");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/trousers.png",
                  text: "パンツ",
                ),
                onTap: () {
                  print("パンツ");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/dress.png",
                  text: "ワンピース/ドレス",
                ),
                onTap: () {
                  print("ワンピース/ドレス");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/skirt.png",
                  text: "スカート",
                ),
                onTap: () {
                  print("スカート");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/socks.png",
                  text: "ソックス",
                ),
                onTap: () {
                  print("ソックス");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/shoes.png",
                  text: "シューズ",
                ),
                onTap: () {
                  print("シューズ");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/cap.png",
                  text: "帽子",
                ),
                onTap: () {
                  print("帽子");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/eyeglasses.png",
                  text: "メガネ",
                ),
                onTap: () {
                  print("メガネ");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/bracelet.png",
                  text: "アクセサリー",
                ),
                onTap: () {
                  print("アクセサリー");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/handbag.png",
                  text: "バッグ",
                ),
                onTap: () {
                  print("バッグ");
                },
              ),
              GestureDetector(
                child: NeumorphicCard(
                  imagePath: "images/hand-watch.png",
                  text: "腕時計",
                ),
                onTap: () {
                  print("腕時計");
                },
              ),
            ],
          ),
        ),

      ]),
    );
  }
}
