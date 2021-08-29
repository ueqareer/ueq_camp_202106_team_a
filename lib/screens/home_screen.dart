import 'package:cordinate_sns_app/widgets/custom_network_image.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_bottom_navigation.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_coordination_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> nameList = [];
  List<String> profileImageUrlList = [];

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

    // print(userNameMap);

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

    // print(profileImageUrlMap);

    return Future.value(profileImageUrlMap);
  }

  Future<List<List<dynamic>>> getCoordinateDataFromFirestore() async {
    List<List<dynamic>> coordinationDimList = [];

    Map<String, String> userNameMap = {};
    Map<String, String> userProfileImageUrlMap = {};
    Future<Map<String, String>> userNameMapFuture = getUserName();
    Future<Map<String, String>> userProfileImageUrlFuture =
        getProfileImageUrl();
    await userNameMapFuture.then((value) => userNameMap = value);
    await userProfileImageUrlFuture
        .then((value) => userProfileImageUrlMap = value);

    this.nameList.clear();
    this.profileImageUrlList.clear();
    var collection = FirebaseFirestore.instance.collection('coordination');
    await collection
        .orderBy('createdAt', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        List<dynamic> coordinationList = doc.get('coordination');
        List<String> afterCastCoordinationList =
            coordinationList.cast<String>();
        coordinationDimList.add(afterCastCoordinationList);
        var uid = doc.get('uid');
        var userName = userNameMap[uid];
        var userProfileImageUrl = userProfileImageUrlMap[uid];
        this.nameList.add(userName!);
        this.profileImageUrlList.add(userProfileImageUrl!);
      });
    });

    return Future.value(coordinationDimList);
  }

  Future<List<NeumorphicCoordinationCard>> initVerticalList() async {
    List<NeumorphicCoordinationCard> neumorphicCoordinationCardList = [];

    var coordinationDimList = await getCoordinateDataFromFirestore();

    for (int i = 0; i < coordinationDimList.length; i++) {
      List<Widget> images =
          initHorizontalList(i, coordinationDimList[i].cast<String>());
      NeumorphicCoordinationCard card = NeumorphicCoordinationCard(
        images: images,
        name: this.nameList[i],
        profileImageUrl: this.profileImageUrlList[i],
      );
      neumorphicCoordinationCardList.add(card);
    }

    return neumorphicCoordinationCardList;
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
              AsyncSnapshot<List<NeumorphicCoordinationCard>> snapshot) {
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
        bottomSheet: NeumorphicBottomNavigation(),
      ),
    );
  }
}
