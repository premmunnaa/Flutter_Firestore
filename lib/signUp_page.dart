import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignupPage extends StatefulWidget {
  static String tag = 'signup-page';
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignupPage> {

  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _sbkey = new GlobalKey<ScaffoldState>();
  String _email;
  String _pass;
  String _confim;
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller1 = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();


  void showsnackbar(){
    _controller.clear();
    _controller1.clear();
    _controller2.clear();
    _sbkey.currentState.showSnackBar(new SnackBar(content: new Text('Register success')));
  }

  bool validateandSave(){
    final form3 = formkey3.currentState;
    final form1 = formkey1.currentState;
    final form2 = formkey2.currentState;

    if(form1.validate() && form2.validate() && form3.validate())
    {
      form1.save();
      form2.save();
      form3.save();

      if(_pass!=_confim){
        return false;
      }
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
            .createUserWithEmailAndPassword(email: _email, password: _pass);
        showsnackbar();
      }
      catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {



    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('Images/logo.png'),
      ),
    );

    final email = Form(
      key: formkey1,
      child:
      TextFormField(
        controller: _controller,
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
        controller: _controller1,
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

    final confpass= Form(
      key: formkey3,
      child:TextFormField(
        controller: _controller2,
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confirm Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
        onSaved: (value) => _confim = value,
      ),
    );

    final signUpButton = Padding(
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
        child: Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );
    final backtoLogin = FlatButton(
      child: Text(
        'Registered ? then Login here',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {Navigator.of(context).pushNamed('LoginPage');},
    );

    return Scaffold(
      key: _sbkey,
      body: Container(
        decoration: new BoxDecoration(
        image: new DecorationImage(
        image: new AssetImage('Images/p1.png'),
    fit: BoxFit.cover
    )
    ),
    child:Center(
        child:
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            confpass,
            SizedBox(height: 24.0,),
            signUpButton,
            SizedBox(height: 8.0),
            backtoLogin,

          ],
        ),
      ),
      ),
    );
  }
}
