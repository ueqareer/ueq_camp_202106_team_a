import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_appbar.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_text_for_heading.dart';
import 'package:cordinate_sns_app/widgets/column_containing_image_and_text.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SelectHowToRegistrateClothesScreen extends StatelessWidget {
  final _imagePicker = ImagePicker();
  String _imagePath = "";
  String _imageName = "";
  String _clothesImageUrl = "";
  String clothingCategory;

  SelectHowToRegistrateClothesScreen({required this.clothingCategory});

  Future _getImageFromCamera() async {
    final _pickedFile = await this._imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 30,
        );

    if (_pickedFile != null) {
      this._imagePath = _pickedFile.path;
      this._imageName = this._imagePath.split('/').last;
    }
  }

  Future _getImageFromGallery() async {
    final _pickedFile = await this._imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );

    if (_pickedFile != null) {
      this._imagePath = _pickedFile.path;
      this._imageName = this._imagePath.split('/').last;
    }
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

  Future<void> _uploadClothesImageToFireStorage(
      String uid, String clothingCategory) async {
    late File file = File(this._imagePath);
    try {
      final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
      final TaskSnapshot storedImage = await _firebaseStorage
          .ref("$uid/$clothingCategory/")
          .child('$_imageName')
          .putFile(file);
      await downloadClothesImageUrlFromFireStorage(storedImage);
    } catch (e) {
      print('Failed to upload profile image to FireStorage.');
    }
  }

  Future<void> downloadClothesImageUrlFromFireStorage(
      TaskSnapshot storedImage) async {
    final String downloadUrl = await storedImage.ref.getDownloadURL();
    print("download url：$downloadUrl");
    this._clothesImageUrl = downloadUrl;
  }

  Future<void> postClothesDataToFirestore(String clothingCategory) async {
    String uid = getUidOfCurrentUser();
    CollectionReference _clothes = FirebaseFirestore.instance
        .collection("clothes")
        .doc("$uid")
        .collection("$clothingCategory");

    _clothes.doc().set({
      "clothingImageUrl": _clothesImageUrl,
      "createdAt": Timestamp.fromDate(DateTime.now()),
    });
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
          child: SizedBox(
            height: 300,
            width: 300,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.rect(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NeumorphicTextForHeading(
                    text: "服の登録方法を選択",
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: ColumnContainingImageAndText(
                          imagePath: "images/camera.png",
                          text: "撮影して登録",
                          imageHeight: 90.0,
                          imageWidth: 90.0,
                          fontSize: 15.0,
                        ),
                        onTap: () async {
                          print("撮影して登録");
                          String uid = getUidOfCurrentUser();
                          await _getImageFromCamera();
                          await _uploadClothesImageToFireStorage(
                              uid, this.clothingCategory);
                          await postClothesDataToFirestore(
                              this.clothingCategory);
                          Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        child: ColumnContainingImageAndText(
                          imagePath: "images/album.png",
                          text: "ライブラリから登録",
                          imageHeight: 90.0,
                          imageWidth: 90.0,
                          fontSize: 15.0,
                        ),
                        onTap: () async {
                          print("ライブラリから選択");
                          String uid = getUidOfCurrentUser();
                          await _getImageFromGallery();
                          await _uploadClothesImageToFireStorage(
                              uid, this.clothingCategory);
                          await postClothesDataToFirestore(
                              this.clothingCategory);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
