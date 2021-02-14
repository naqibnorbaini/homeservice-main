import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addUser extends StatelessWidget {
  final String email;
  final String password;
  final String username;
  final String phonenumber;


  addUser(this.username, this.phonenumber,this.email, this.password);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'email': email,
        'password': password,
        'username': username, // John Doe
        'phonenumber': phonenumber, // Stokes and Sons

      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}
