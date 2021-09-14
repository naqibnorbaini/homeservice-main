import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeservice/authenticationservice.dart';

class PendingBooking extends StatefulWidget {

  final String uid;
  PendingBooking({this.uid});


  @override

  _PendingBookingState createState() => _PendingBookingState();
}
class _PendingBookingState extends State<PendingBooking> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;
  void initState() {
    super.initState();
    initUser();
  }
  initUser() async {
    user = auth.currentUser;
    setState(() {});
    print(user.uid);
  }


  @override
  Widget build(BuildContext context) {

    bookingHistory(){
      return FirebaseFirestore.instance
          .collection('booking')
          .where("serviceID", isEqualTo: user.uid )
          .snapshots();
    }

    deleteBooking() {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      final uid = user.uid;
      return FirebaseFirestore.instance
          .collection('booking')
          .doc(uid)
          .delete();
    }


    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            'Pending Booking'),
        backgroundColor: Colors.deepOrange,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: bookingHistory(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }


            return ListView(
              children: snapshot.data.docs.map((document) {
                return Card(
                  child: ListTile(
                    isThreeLine: true,
                      title: Text(("" + document['title'])+ (" ,"+document['name'])),
                      subtitle: Text(("" + document['address'])+ (" ,"+document['date'])+ (" ,"+document['time'])+ (" ,"+document['phonenumber'])),

                      trailing: new IconButton(
                        icon: new Icon(Icons.delete),
                        onPressed: ()async{
                          await FirebaseFirestore.instance.collection('booking').doc(document.id).delete();

                        },
                      )
                  ),
                );

              }).toList(),
            );
          }

      ),
    );
  }
}