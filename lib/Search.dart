
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:homeservice/HomeCleaning.dart';
import 'package:homeservice/service/DataController.dart';
import 'package:homeservice/DetailPage.dart';

class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExecuted =  false;

  @override
  Widget build(BuildContext context) {


    Widget searchedData(){
          return ListView.builder(

          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeCleaning(),
                  ),);

              },
              child: Card(
                  child: ListTile(
                  title: Text(snapshotData.docs[index].data()['title']),
                  subtitle: Text(snapshotData.docs[index].data()['district']),


              )
              ),
            );
          }
      );
    }

    return new Scaffold(
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.clear), onPressed: (){},),
      appBar: new AppBar(
        actions: [
          GetBuilder<DataController>(
              init: DataController(),
              builder:(val){
                return IconButton(icon: Icon(Icons.search), onPressed: (
                    ){
                  val.queryData(searchController.text).then((value) {
                    snapshotData= value;
                    setState(() {
                      isExecuted = true;
                    });
                  });
                });
              }
          )
        ],
        automaticallyImplyLeading: false,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
          ),
              controller: searchController,
          ),
            ),
      body: isExecuted ? searchedData() : Container(
        child: Center(
          child: Text('Search any services')
        ),
      ),
      );
    
  }
}
