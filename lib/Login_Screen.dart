import 'package:flutter/material.dart';
import 'package:homeservice/ServiceProvider/SignUpService.dart';
import 'package:homeservice/SignUpPage.dart';
import 'package:homeservice/authenticationservice.dart';
import 'package:provider/provider.dart';
import 'package:homeservice/ServiceProvider/LoginService.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true
          ,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Home Service',
                      style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      labelText: 'E-Mail',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    //forgot password screen
                  },
                  textColor: Colors.cyan,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.cyan,
                      child: Text('Login'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                       context.read<AuthenticationService>().signIn(
                         email: emailController.text,
                         password: passwordController.text,
                       );
                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[

                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Sign Up User',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>SignUpPage()),
                            );//signup screen
                          },
                        ),

                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Sign Up Services',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>SignUpService()),
                            );//signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
}