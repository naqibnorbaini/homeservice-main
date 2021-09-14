import "package:flutter/material.dart";
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

class Profile extends StatefulWidget {

  final String uid;

  Profile({this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}
TextEditingController passwordController = TextEditingController();



class _ProfileState extends State<Profile> {
  final picker = ImagePicker();
  File _image;




  final FirebaseAuth _auth = FirebaseAuth.instance;
  User users;
  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    users = await _auth.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    Future getImage() async{
      var image= await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (image != null) {
          _image = File(image.path);
        } else {
          print('No image selected.');
        }
      });

      Future uploadPic(BuildContext context) async{
        String filename = basename(_image.path);
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child(filename);
        UploadTask uploadTask = ref.putFile(_image);
        uploadTask.whenComplete(() {
          print("Profile Picture Uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
        });
      }

    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
              'Profile'),
        ),
        body: StreamBuilder(

            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Center(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 80,
                        child: Image.network(""),
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 60.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera,
                            size: 30.0,
                          ),
                          onPressed: (){
                            getImage();
                          },
                        ),
                      ),

                      Text(
                        'User Information',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                        width: 200,
                        child: Divider(
                          color: Colors.teal[100],
                        ),
                      ),


                      Card(
                        color: Colors.white,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.people,
                            color: Colors.teal[900],
                          ),

                          title: Text("${users?.displayName}"),
                        ),
                      ) ,

                      Card(

                        color: Colors.white,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: Colors.teal[900],
                          ),
                          title: Text("${users?.email}"),
                          ),
                        ),
                      RaisedButton(

                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingHistory(),
                            ),);

                        },
                        child: Text("Booking History"),
                      ),

                      RaisedButton(
                        onPressed: () {
                          context.read<AuthenticationService>().signOut();
                        },
                        child: Text("Sign Out"),
                      ),
                 

                    ],
                  )

              );

            }
        )
    );


  }
}

