
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseService{
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference booking = FirebaseFirestore.instance.collection('booking');
  final CollectionReference HomeCleaning = FirebaseFirestore.instance.collection('HomeCleaning');
  final CollectionReference Carpet = FirebaseFirestore.instance.collection('CarpetCleaning');
  final CollectionReference Grass = FirebaseFirestore.instance.collection('GrassCutting');
  final CollectionReference Paint = FirebaseFirestore.instance.collection('PaintJob');
  final CollectionReference Sanitize = FirebaseFirestore.instance.collection('HomeSanitize');
  final CollectionReference Vacuum = FirebaseFirestore.instance.collection('VacuumCleaning');
  final CollectionReference Window = FirebaseFirestore.instance.collection('WindowCleaning');
  final CollectionReference Wiring = FirebaseFirestore.instance.collection('Wiring');

  Future updateUserData( String email, String password, String username, String phonenumber) async {
    
    return await users.doc(uid).set(
        {

          'username': username,
          'Email': email,
          'Password': password,
          'phonenumber': phonenumber,
          'role': "User",

        });
  }

  Future updateServiceData( String email, String password, String username, String phonenumber) async {

    return await users.doc(uid).set(
        {

          'username': username,
          'Email': email,
          'Password': password,
          'phonenumber': phonenumber,
          'role': "Service Provider",
        });
  }


  Future addBooking( String name, String phonenumber, String address,  String notes, String title, String district, String time, String date, String userID, String serviceID) async {
    return await booking.doc().set(
        {

          'name': name,
          'phonenumber': phonenumber,
          'address': address,
          'notes': notes,
          'time': time,
          'date': date,
          'title': title,
          'district': district,
          'User ID': uid,
          'serviceID': serviceID,


        });
  }

  Future addHome(String title,String district, String rate, String description, String serviceID)async{
    return await HomeCleaning.doc().set(
        {
          'title': title,
          'district': district,
          'rate': rate,
          'description': description,
          'serviceID': uid,
        });
  }

  Future addCarpet(String title,String district, String rate, String description, String serviceID)async{
    return await Carpet.doc().set(
        {
          'title': title,
          'district': district,
          'rate': rate,
          'description': description,
          'serviceID': uid,
        });
  }

  Future addGrass(String title,String district, String rate, String description, String serviceID)async{
    return await Grass.doc().set(
        {
          'title': title,
          'district': district,
          'rate': rate,
          'description': description,
          'serviceID': uid,
        });
  }

  Future addPaint(String title,String district, String rate, String description, String serviceID)async{
    return await Paint.doc().set(
        {
          'title': title,
          'district': district,
          'rate': rate,
          'description': description,
          'serviceID': uid,
        });
  }

  Future addSanitize(String title,String district, String rate, String description, String serviceID)async{
    return await Sanitize.doc().set(
        {
          'title': title,
          'district': district,
          'rate': rate,
          'description': description,
          'serviceID': uid,
        });
  }

  Future addVacuum(String title,String district, String rate, String description, String serviceID)async{
    return await Vacuum.doc().set(
        {
          'title': title,
          'district': district,
          'rate': rate,
          'description': description,
          'serviceID': uid,
        });
  }

  Future addWindow(String title,String district, String rate, String description, String serviceID)async{
    return await Window.doc().set(
        {
          'title': title,
          'district': district,
          'rate': rate,
          'description': description,
          'serviceID': uid,
        });
  }

  Future addWiring(String title,String district, String rate, String description, String serviceID)async{
    return await Wiring.doc().set(
        {
          'title': title,
          'district': district,
          'rate': rate,
          'description': description,
          'serviceID': uid,
        });
  }

  Future displayData( String email, String username,  String phonenumber) async {
      return await users.doc(uid).set(
          {
            'username': username,
            'Email': email,
            'phonenumber': phonenumber,
          }
          );

  }
  final firestore = FirebaseFirestore.instance;   //
  FirebaseAuth auth = FirebaseAuth.instance;     //recommend declaring a reference outside the methods

  Future<String> getUserName() async {

    final CollectionReference users = firestore.collection('users');

    final String uid = auth.currentUser.uid;

    final result = await users.doc(uid).get();

    

  }




}