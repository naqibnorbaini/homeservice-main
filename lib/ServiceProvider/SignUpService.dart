import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeservice/MainPage.dart';
import 'package:homeservice/ServiceProvider/MainPageServiceProvider.dart';
import 'package:homeservice/authenticationservice.dart';
import 'package:homeservice/home.dart';
import 'package:provider/provider.dart';

class SignUpService extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignUpService> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Service Provider'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: _formKey,
        child: ListView(

          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Enter Your Account Information',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),),
                  labelText: 'Username',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Username is empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),),
                  labelText: 'E-Mail',

                ),
                validator: (text) {
                  if (!(text.contains('@')) && text.isNotEmpty) {
                    return "Enter a valid email address!";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),),
                  labelText: 'Phone Number',
                ),
                validator: (text) {
                  if (text.length < 10 || text.isEmpty) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),),
                  labelText: 'Password',
                ),
                validator: (text) {
                  if (text.length < 6 || text.isEmpty) {
                    return 'Password must be longer than 6 characters';
                  }
                  return null;
                },
              ),
            ),

            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.deepOrange,
                  child: Text('Sign Up'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      showAlertDialog(context);
                      // TODO submit
                    }

                    context.read<AuthenticationService>().signUpService(
                      email: emailController.text,
                      password: passwordController.text,
                      phonenumber: phoneController.text,
                      username: usernameController.text,
                    );
                    User updateUser = FirebaseAuth.instance.currentUser;
                    updateUser.updateProfile(displayName: usernameController.text);
                    userSetup(usernameController.text);

                  },


                )
            ),
          ],
        ),
      ),
    );
  }

  void userSetup(String text) {}
}
showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPageService(),
        ),); },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Welcome!"),
    content: Text("You are successfully signed up!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
