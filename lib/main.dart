 import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'signUp_page.dart';
import 'profile.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',
      routes: {
        'initial':(context)=>MyHomePage(),
        'upload' :(context)=>UploadDetails(),
        'LoginPage': (context) => LoginPage(),
        'SignupPage':(context)=>SignupPage(),
        'profile':(context)=>ProfilePage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState(){
    Firestore().settings(timestampsInSnapshotsEnabled: true);
  }
  navigate(){
    Navigator.of(context).pushNamed('LoginPage');
  }
  @override
  Widget build(BuildContext context) {


    Widget titleSection(name,lname){
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    lname,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    Widget textSection(para) {
     return Container(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          para,
          softWrap: true,
        ),
      );
    }
    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Telugu Matrimony'),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Premkumar'),
              accountEmail: new Text('premmano982gmail.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('P'),
              ),
            ),
            new ListTile(
              title: new Text('My orders'),
              trailing: Icon(Icons.favorite),
              onTap: ()=>Navigator.of(context).pushNamed('profile'),
            ),
            new Divider(),
            new ListTile(
              title: new Text('My Profile'),
              trailing: Icon(Icons.people),
              onTap: ()=>Navigator.of(context).pushNamed('upload'),
            ),
            new Divider(),
            new ListTile(
              title: new Text('My Cart'),
              trailing: Icon(Icons.payment),
            ),
            new Divider(),
            new ListTile(
              title: new Text('Log Out'),
              trailing: Icon(Icons.close),
              onTap:(){
                FirebaseAuth.instance.signOut().then(navigate());
              }
            ),
          ],
        ),
      ),
      body:StreamBuilder(
        stream: Firestore.instance.collection('names').snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Text('Loading...Please wait');
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,i){

            },
          );
        },
      ),
    );
  }
}
