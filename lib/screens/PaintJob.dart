import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeservice/DetailPage.dart';

class PaintJob extends StatefulWidget {
  @override
  _PaintJobState createState() => _PaintJobState();
}

class _PaintJobState extends State<PaintJob> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            'Paint Job'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('PaintJob').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }


            return ListView(
              children: snapshot.data.docs.map((document) {
                return Card(
                  child: ListTile(
                    title: Text(("" + document['title'])),
                    subtitle: Text(("" + document['district'])),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(document),
                        ),);
                    },
                  ),
                );

              }).toList(),
            );
          }

      ),
    );
  }
}
