import 'package:cordinate_sns_app/screens/select_clothes_category_for_choosing_clothes.dart';
import 'package:cordinate_sns_app/screens/selecting_clothes_for_recuitment_screen.dart';
import 'package:cordinate_sns_app/screens/selecting_clothes_screen.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_text_for_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_appbar.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_multi_line_textfield.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_button.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateRecruitmentOfCoordination extends StatefulWidget {
  @override
  _CreateRecruitmentOfCoordinationState createState() =>
      _CreateRecruitmentOfCoordinationState();
}

class _CreateRecruitmentOfCoordinationState
    extends State<CreateRecruitmentOfCoordination> {
  String recruitmentMessage = "";
  String usageSceneMessage = "";
  String? clothingImageUrl = "";
  TextEditingController _controllerForRecruitment = TextEditingController();
  TextEditingController _controllerForUsageScene = TextEditingController();

  void initMessages() {
    this.recruitmentMessage = "";
    this.usageSceneMessage = "";
  }

  void initClothingImageUrl() {
    setState(() {
      this.clothingImageUrl = "";
    });
  }

  String getUidOfCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return "";
    } else {
      String uid = user.uid;
      return uid;
    }
  }

  Future<void> postRecruitmentDataToFirestore(
      String recruitmentMessage,
      String usageSceneMessage,
      String? clothingImageUrl,
      TextEditingController controllerForRecruitment,
      TextEditingController controllerForUsageScene) async {
    if (clothingImageUrl == null) {
      clothingImageUrl = "";
    }
    String uid = getUidOfCurrentUser();
    CollectionReference _recruitment =
        FirebaseFirestore.instance.collection('recruitment');
    if (recruitmentMessage.isNotEmpty && usageSceneMessage.isNotEmpty) {
      print("募集");
      _recruitment
          .doc()
          .set({
            'uid': uid,
            'createdAt': Timestamp.fromDate(DateTime.now()),
            "recruitmentMessage": recruitmentMessage,
            "usageSceneMessage": usageSceneMessage,
            "clothesImageUrl": clothingImageUrl,
          })
          .then((value) =>
              print("Succeed to post recruitment data to Firestore."))
          .catchError((error) =>
              print('Failed to post recruitment data to Firestore.：$error'));
      controllerForRecruitment.clear();
      controllerForUsageScene.clear();
      initMessages();
      initClothingImageUrl();
    }
  }

  Widget displayDefaultClothesImage() {
    return Neumorphic(
      padding: EdgeInsets.all(30),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.rect(),
        depth: NeumorphicTheme.embossDepth(context),
      ),
      child: Center(
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Image(
                image: AssetImage("images/parker.png"),
              ),
            ),
            SizedBox(
              height: 10,
              width: 10,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  Widget switchClothesImages(String? clothingImageUrl) {
    if (clothingImageUrl == null) {
      return displayDefaultClothesImage();
    }

    if (clothingImageUrl.isNotEmpty) {
      return Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.rect(),
          depth: NeumorphicTheme.embossDepth(context),
        ),
        child: Center(
          child: SizedBox(
            height: 120,
            width: 120,
            child: Image(
              image: NetworkImage(clothingImageUrl),
            ),
          ),
        ),
      );
    } else {
      return displayDefaultClothesImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: NeumorphicCustomAppBar(
            title: "Coordinate App",
            fontSize: 30.0,
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomSpace),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicTextForTextField(
                      text: "コーディネート募集するためのメッセージを入力",
                      color: Colors.black,
                    ),
                    NeumorphicMultiLineTextField(
                      hint: "",
                      onChanged: (recruitmentMessage) {
                        this.recruitmentMessage = recruitmentMessage;
                      },
                      controller: this._controllerForRecruitment,
                    ),
                    NeumorphicTextForTextField(
                        text: "コーディネートを着る場面を入力", color: Colors.black),
                    NeumorphicMultiLineTextField(
                      hint: "",
                      onChanged: (contentsOfUsageScene) {
                        this.usageSceneMessage = contentsOfUsageScene;
                      },
                      controller: this._controllerForUsageScene,
                    ),
                    NeumorphicTextForTextField(
                      text: "コーディネートで使用したい服がある場合は選択",
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: GestureDetector(
                          onTap: () async {
                            final clothingImageUrl = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SelectClothesCategoryForChoosingClothesScreen(),
                              ),
                            );

                            setState(() {
                              this.clothingImageUrl = clothingImageUrl;
                            });
                          },
                          child: switchClothesImages(this.clothingImageUrl),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: NeumorphicCustomButton(
                        text: "募集",
                        color: Colors.black,
                        onPressed: () => postRecruitmentDataToFirestore(
                          this.recruitmentMessage,
                          this.usageSceneMessage,
                          this.clothingImageUrl,
                          this._controllerForRecruitment,
                          this._controllerForUsageScene,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
