import "package:flutter/material.dart";
import "package:flutter/material.dart";
import 'package:homeservice/AddServiceScreens/PendingBooking.dart';
import 'package:homeservice/AddServiceScreens/ServiceMain.dart';
import 'package:homeservice/BookingHistory.dart';
import 'package:homeservice/authenticationservice.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:homeservice/ServiceProvider//MainPageServiceProvider.dart';


class MainPageService extends StatelessWidget {

  var services = [
    "Add Service",
    "Pending Services",
    "Logout",

  ];

  var images = [
    "image/addservice.png",
    "image/pendingservice.png",
    "image/logout.png"

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
              'Home'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: GridView.builder(
              itemCount: services.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery
                      .of(context)
                      .size
                      .width / (MediaQuery
                      .of(context)
                      .size
                      .height / 2)
              ),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: InkWell(
                      onTap: () {
                        if (services[index] == "Add Service") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ServiceMain())
                          );
                        } else if (services[index] == "Pending Services") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PendingBooking())
                          );
                        }else if (services[index] == "Logout") {
                          context.read<AuthenticationService>().signOut();
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(images[index], height: 40, width: 50,),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(services[index], style: TextStyle(
                                fontSize: 16,
                                height: 1.2,
                                fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                          ),


                        ],
                      ),

                    ))
                ;
              }
          ),

        )
    );
  }
}
