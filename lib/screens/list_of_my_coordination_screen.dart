import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cordinate_sns_app/screens/select_my_coordination_screen.dart';
import 'package:cordinate_sns_app/widgets/custom_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_appbar.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_my_coordination_card.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfMyCoordinationScreen extends StatefulWidget {
  String uid;

  ListOfMyCoordinationScreen({required this.uid});

  @override
  _ListOfMyCoordinationScreenState createState() =>
      _ListOfMyCoordinationScreenState();
}

class _ListOfMyCoordinationScreenState
    extends State<ListOfMyCoordinationScreen> {
  Future<Map<String, String>> getUserName() async {
    var collection = FirebaseFirestore.instance.collection('users');

    Map<String, String> userNameMap = {};

    await collection.get().then((value) {
      value.docs.forEach((element) {
        var uid = element.get('uid');
        var userName = element.get('userName');

        userNameMap[uid] = userName;
      });
    });

    return Future.value(userNameMap);
  }

  Future<Map<String, String>> getProfileImageUrl() async {
    var collection = FirebaseFirestore.instance.collection('users');

    Map<String, String> profileImageUrlMap = {};

    await collection.get().then((value) {
      value.docs.forEach((element) {
        var uid = element.get('uid');
        var profileImageUrl = element.get('profileImageUrl');

        profileImageUrlMap[uid] = profileImageUrl;
      });
    });

    return Future.value(profileImageUrlMap);
  }

  Future<List<List<dynamic>>> getCoordinateDataFromFirestore() async {
    List<List<dynamic>> coordinationDimList = [];

    var collection = FirebaseFirestore.instance.collection('coordination');
    await collection
        .orderBy('createdAt', descending: true)
        .where('uid', isEqualTo: widget.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        List<dynamic> coordinationList = doc.get('coordination');
        List<String> afterCastCoordinationList =
            coordinationList.cast<String>();
        coordinationDimList.add(afterCastCoordinationList);
      });
    });

    return Future.value(coordinationDimList);
  }

  Future<List<NeumorphicMyCoordinationCard>> initVerticalList() async {
    List<NeumorphicMyCoordinationCard> neumorphicMyCoordinationCardList = [];

    var coordinationDimList = await getCoordinateDataFromFirestore();

    for (int i = 0; i < coordinationDimList.length; i++) {
      List<Widget> images =
          initHorizontalList(i, coordinationDimList[i].cast<String>());
      NeumorphicMyCoordinationCard card = NeumorphicMyCoordinationCard(
        images: images,
      );
      neumorphicMyCoordinationCardList.add(card);
    }

    return neumorphicMyCoordinationCardList;
  }

  List<Widget> initHorizontalList(int i, List<String> coordinationList) {
    List<Widget> images = [];
    for (int j = 0; j < coordinationList.length; j++) {
      images.add(
        CustomNetworkImage(
          imageUrl: coordinationList[j],
          padding: 5,
          height: 125,
          width: 125,
        ),
      );
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: NeumorphicCustomAppBar(
          title: "Coordinect",
          fontSize: 30,
        ),
        body: FutureBuilder(
          future: initVerticalList(),
          builder: (BuildContext context,
              AsyncSnapshot<List<NeumorphicMyCoordinationCard>> snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!,
            );
          },
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(
            bottom: 50,
          ),
          child: NeumorphicFloatingActionButton(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset('images/tshirt.png'),
                ),
                SizedBox(
                  height: 18,
                  width: 18,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SelectMyCoordinationScreen(uid: widget.uid),
                ),
              );
            },
          ),
        ),
        bottomSheet: NeumorphicBottomNavigation(),
      ),
    );
  }
}
