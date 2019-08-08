import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String _usid;
  _ProfilePageState(){
    Firestore().settings(timestampsInSnapshotsEnabled: true);
    userid();
  }

  userid()async{

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _usid = user.uid;
    });
  }
  @override
  Widget build(BuildContext context) {

    Widget image(photo) {
      Padding(
        padding: EdgeInsets.all(10.0),
        child:
        Container(
          padding: EdgeInsets.all(10.0),
          height: 350.0,
          width: 400.0,
          color: Colors.cyan,
          child: Center(child: Image.network(photo)),
        ),
      );
    }

    Widget text1(name) {
      Padding(
        padding: EdgeInsets.all(10.0),
        child: new Container(
          height: 50.0,
          width: 400.0,
          color: Colors.amberAccent,
          child: Center(child: Text(name),
          ),
        ),
      );
    }
    Widget text2(lname) {
      Padding(
        padding: EdgeInsets.all(10.0),
        child: new Container(
          height: 50.0,
          width: 400.0,
          color: Colors.amberAccent,
          child: Center(child: Text(lname),
          ),
        ),
      );
    }
    Widget text3(para) {
      Padding(
        padding: EdgeInsets.all(10.0),
        child: new Container(
          height: 50.0,
          width: 400.0,
          color: Colors.amberAccent,
          child: Center(child: Text(para),
          ),
        ),
      );
    }
    return Scaffold(
      body:StreamBuilder(
        stream: Firestore.instance.collection(_usid).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Text('Loading...Please wait');
          }
          new ListView(
                children: <Widget>[
                 image(snapshot.data['photo']),
                  text1(snapshot.data['name']),
                  text2(snapshot.data['lname']),
                 text2(snapshot.data['para']),
                ],
              );
            },
      ),

    );
  }
}
