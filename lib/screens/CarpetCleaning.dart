import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeservice/DetailPage.dart';

class CarpetCleaning extends StatefulWidget {
  @override
  _CarpetCleaningState createState() => _CarpetCleaningState();
}

class _CarpetCleaningState extends State<CarpetCleaning> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            'Grass Cutting'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('CarpetCleaning').snapshots(),
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