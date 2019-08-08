import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final sbkey = GlobalKey<ScaffoldState>();

  bool load = false;

  String _email;
  String _pass;

  bool validateandSave(){

    final form1 = formkey1.currentState;
    final form2 = formkey2.currentState;

    if(form1.validate() && form2.validate())
    {
      form1.save();
      form2.save();
      return true;
    }
    else
    {
      return false;
    }
  }

  void authenticate()async {
    if (validateandSave()) {
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _pass);
        Navigator.of(context).pushNamed('initial');
      }
      catch (e) {
        print(e);
        sbkey.currentState.showSnackBar(new SnackBar(content: new Text('Please check your email and password')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 68.0,
        child: Image.asset('Images/logo.png'),
      ),
    );

    final email = Form(
      key: formkey1,
      child:
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        validator: (value)=> value.isEmpty ? 'Email cannot be empty ': null,
        onSaved: (value) => _email = value,
      ),
    );

    final password = Form(
      key: formkey2,
      child:TextFormField(
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        validator: (value)=> value.isEmpty ? 'Password cannot be empty ': null,
        onSaved: (value) => _pass = value,
      ),
    );

    final loginButton =
    Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          authenticate();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final signUpButton =Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('SignupPage');
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      key: sbkey,
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage('Images/p1.png'),
              fit: BoxFit.cover
          )
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  loginButton,
                  signUpButton
                ],),
              forgotLabel
            ],
          ),
        ),
      ),
    );
  }
}
