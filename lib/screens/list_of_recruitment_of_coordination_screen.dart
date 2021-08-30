import 'package:cordinate_sns_app/screens/create-recruitment-of-coordination.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_custom_appbar.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_recruitment_card.dart';
import 'package:cordinate_sns_app/widgets/neumorphic_bottom_navigation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ListOfRecruitmentOfCoordinationScreen extends StatefulWidget {
  const ListOfRecruitmentOfCoordinationScreen({Key? key}) : super(key: key);

  @override
  _ListOfRecruitmentOfCoordinationScreenState createState() =>
      _ListOfRecruitmentOfCoordinationScreenState();
}

class _ListOfRecruitmentOfCoordinationScreenState
    extends State<ListOfRecruitmentOfCoordinationScreen> {
  List<String> uidList = [];
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

  Future<List<String>> getRecruitmentDataFromFirestore() async {
    List<String> recruitmentMessageList = [];

    Map<String, String> userNameMap = {};
    Map<String, String> userProfileImageUrlMap = {};
    Future<Map<String, String>> userNameMapFuture = getUserName();
    Future<Map<String, String>> userProfileImageUrlFuture =
        getProfileImageUrl();
    await userNameMapFuture.then((value) => userNameMap = value);
    await userProfileImageUrlFuture
        .then((value) => userProfileImageUrlMap = value);

    this.uidList.clear();
    this.nameList.clear();
    this.profileImageUrlList.clear();
    var collection = FirebaseFirestore.instance.collection('recruitment');
    await collection
        .orderBy('createdAt', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String recruitmentMessage = doc.get('recruitmentMessage');
        recruitmentMessageList.add(recruitmentMessage);
        var uid = doc.get('uid');
        var userName = userNameMap[uid];
        var userProfileImageUrl = userProfileImageUrlMap[uid];
        this.uidList.add(uid);
        this.nameList.add(userName!);
        this.profileImageUrlList.add(userProfileImageUrl!);
      });
    });

    return Future.value(recruitmentMessageList);
  }

  Future<List<NeumorphicRecruitmentCard>> initVerticalList() async {
    List<NeumorphicRecruitmentCard> neumorphicRecruitmentCardList = [];

    var recruitmentMessageList = await getRecruitmentDataFromFirestore();

    for (int i = 0; i < recruitmentMessageList.length; i++) {
      NeumorphicRecruitmentCard card = NeumorphicRecruitmentCard(
        uid: this.uidList[i],
        name: this.nameList[i],
        profileImageUrl: this.profileImageUrlList[i],
        recruitmentMessage: recruitmentMessageList[i],
      );
      neumorphicRecruitmentCardList.add(card);
    }

    return neumorphicRecruitmentCardList;
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
              AsyncSnapshot<List<NeumorphicRecruitmentCard>> snapshot) {
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
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset('images/promotion.png'),
                  ),
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
                  builder: (context) => CreateRecruitmentOfCoordination(),
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
