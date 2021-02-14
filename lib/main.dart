import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:homeservice/Login_Screen.dart';
import 'package:homeservice/ServiceProvider/MainPageServiceProvider.dart';
import 'package:homeservice/authenticationservice.dart';
import 'package:homeservice/home.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges,
        ),
      ],
        child: MaterialApp(
        theme: ThemeData(
           fontFamily: 'Raleway',
            primarySwatch: Colors.cyan,
            scaffoldBackgroundColor: const Color(0xFFEFEFEF),
    ),
        home: AuthenticationWrapper()
    ),
      );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context)  {
    final firebaseUser = context.watch<User>();
    String role;
    if (firebaseUser != null) {

      dynamic document = FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get().then((users) => {
        role = users["role"],
        if (role == "User"){
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => Homescreen()))

        } else if (role == "Service Provider"){
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => MainPageService()))
        }
      }
      );

    }
    return LoginPage();
  }

}







