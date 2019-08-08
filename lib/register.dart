import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UploadDetails extends StatefulWidget {

  @override
  _UploadDetailsState createState() => _UploadDetailsState();
}

class _UploadDetailsState extends State<UploadDetails> {

  _UploadDetailsState(){
    firebaseData();
  }


  firebaseData() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _id = user.uid;
    });
  }
  final nkey = GlobalKey<FormState>();
  final adkey1 = GlobalKey<FormState>();
  final adkey2 = GlobalKey<FormState>();
  final adkey3= GlobalKey<FormState>();
  final aboutk = GlobalKey<FormState>();

  var _name;
  String _id;
  var _aad1;
  var _aad2;
  var _aad3;
  var _abt;



  bool getvalue()
  {
    final a = nkey.currentState;
    final c = aboutk.currentState;
    final e = adkey1.currentState;
    final d = adkey3.currentState;
    final b = adkey2.currentState;

    if(a!=null &&  d!=null  && b!=null   && c!=null  && e!=null   ){
      a.save();
      b.save();
      c.save();
      d.save();
      e.save();
      return true;
    }
    else return false;

  }
  File sampleImage;
  Future getImage() async{
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;

    });
  }
upload() {
  if (getvalue()) {
    final StorageReference firebaseRef = FirebaseStorage.instance.ref().child(_id);
    final StorageUploadTask task = firebaseRef.putFile(sampleImage);
    StorageTaskSnapshot storageTaskSnapshot;
    task.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          String photoUrl = downloadUrl;
          Firestore.instance
              .collection('names')
              .document(_id)
              .setData({
            'name': _name,
            'lname': _aad1 + _aad2 + _aad3,
            'para': _abt,
            'photo': photoUrl
          });
        });
      }
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = Form(
      key: nkey,
      child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Enter your Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onSaved: (value)=>_name = value,
      ),
    );
    final addd = Form(
      key: adkey1,
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'Door number',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onSaved: (value)=>_aad1 = value,
      ),
    );
    final addd2 = Form(
      key: adkey2,
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'Street name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onSaved: (value)=> _aad2 = value,
      ),
    );
    final addd3= Form(
      key: adkey3,
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'City/Town Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onSaved: (value)=> _aad3 = value,
      ),
    );
    final about= Form(
      key: aboutk,
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'About Yourself',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onSaved: (value)=>_abt = value,
      ),
    );
    Widget enableUpload() {
      return Container(
        child: Column(
          children: <Widget>[
            Image.file(sampleImage,width: 150,height: 150,),
          ],
        ),
      );
      }
      final Button = new Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            upload();
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: Text('Upload', style: TextStyle(color: Colors.white)),
        ),
      );
    return Scaffold(
      appBar: AppBar(title: Text('Registration'),),
      body:Container(
    decoration: new BoxDecoration(
    image: new DecorationImage(
    image: new AssetImage('Images/p2.jpg'),
    fit: BoxFit.cover
    ),
    ),
    child: new Container(
        padding: EdgeInsets.all(32.0),
        child: ListView(
          children: <Widget>[
            sampleImage ==null ? Column(children: <Widget>[Text('Select Image',style: TextStyle(color: Colors.white),),
            FloatingActionButton(onPressed: getImage,child: Text('+',style: TextStyle(fontSize: 50),),),],): enableUpload(),
            SizedBox(height: 9.0,),
            name,
            SizedBox(height: 9.0,),
            Text('Enter your Address'),
            SizedBox(height: 12.0,),
            addd,
            SizedBox(height: 12.0,),
            addd2,
            SizedBox(height: 12.0,),
            addd3,
            SizedBox(height: 12.0,),
            about,
            SizedBox(height: 12.0,),
            Button,
          ],
        ),
      ),
      ),
    );
  }
}
