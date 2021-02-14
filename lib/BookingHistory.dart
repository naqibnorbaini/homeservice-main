import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeservice/authenticationservice.dart';

class BookingHistory extends StatefulWidget {

  final String uid;
  BookingHistory({this.uid});


  @override

  _BookingHistoryState createState() => _BookingHistoryState();
}
class _BookingHistoryState extends State<BookingHistory> {
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
          .where("User ID", isEqualTo: user.uid )
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
            'Booking History'),
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

                    title: Text(("" + document['title'])),
                    subtitle: Text(("" + document['date'])+ (","+document['time'])),

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
