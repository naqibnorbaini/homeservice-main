import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:homeservice/HomeCleaning.dart';
import 'package:homeservice/service/addUser.dart';
import 'package:homeservice/service/database.dart';
import 'package:homeservice/authenticationservice.dart';
import 'package:provider/provider.dart';
import 'package:homeservice/home.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DetailPage extends StatelessWidget {
  DocumentSnapshot detailDocument;
  DetailPage(this.detailDocument);


  createAlertDialog(BuildContext context){
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController notesController = TextEditingController();



    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    void _saveForm() {
      final isValid = _formKey.currentState.validate();
      if (!isValid) {
        return;
      }
    }

    return showDialog(context: context,builder: (context)
    {

      return AlertDialog(
          scrollable: true,
        title: Text("Enter Your Booking Details"),
          content: Padding(
              padding: const EdgeInsets.all(8.0),
           child: Form(
               key: _formKey,
           child: SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: 'Name',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Name is empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: 'Phone Number',
                ),
                validator: (text) {
                  if (text.length < 10 || text.isEmpty) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: 'Address',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Address is empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: timeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: 'Time (e.g. 11.00 AM)',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter the time of appointment';
                  }
                  return null;
                },
              ),
            ), Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: 'Date (dd/mm/yy)',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter the date of appointment';
                  }
                  return null;
                },
              ),
            ),





            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: notesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: 'Notes',
                ),
              ),
            ),
                RaisedButton(
                    textColor: Colors.white,
                    color: Colors.cyan,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  child: Text('Submit'),
                  onPressed:() {
                    if (_formKey.currentState.validate()) {

                      context.read<AuthenticationService>().addBooking(
                        name : nameController.text,
                        phonenumber: phoneController.text,
                        address: addressController.text,
                        notes: notesController.text,
                        title: detailDocument['title'],
                        district: detailDocument['district'],
                        serviceID: detailDocument['serviceID'],
                        time: timeController.text,
                        date: dateController.text,
                      );
                      showAlertDialog(context);
                      // TODO submit
                    }
                    }
                )

          ],
        ),

      ))
      ))
      ;
    });




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 25,right: 25,bottom: 25),
          height: 49,
          color: Colors.cyan,
          child: FlatButton(
            onPressed: (){
              createAlertDialog(context);
            },
            child: Text('Book Now'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
        body: Center(
          child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text((""),
                      style: TextStyle(
                        color: Colors.white,)),
                  expandedHeight: 350.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        'https://tallypress.com/wp-content/uploads/2019/07/top-10-house-cleaning-services-kl-selangor.jpg',
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                SliverList(delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.only(top: 24, left: 25),
                        child: Text(("" + detailDocument['title']),
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7, left: 25),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('\$',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(("" + detailDocument['rate']),
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Text('per hour',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 28,
                        margin: EdgeInsets.only(top: 23, bottom: 36),
                        padding: EdgeInsets.only(left: 25),
                        child: DefaultTabController(
                            length: 1,
                            child: TabBar(
                                labelPadding: EdgeInsets.all(0),
                                indicatorPadding: EdgeInsets.all(0),
                                labelColor: Colors.black,
                                tabs: [
                                  Tab(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 39),
                                      child: Text('Description'),
                                    ),
                                  ),


                                ] )
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 25,right: 25,bottom: 25),
                          child: Text(("" + detailDocument['description'])
                          )
                      ),


                    ]),
                ),
              ]
          ),)
    );

  }
}

showAlertDialog(BuildContext context) {

  // set up the button

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Homescreen(),
        ),); },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Booked!"),
    content: Text("You have succesfully booked a service "),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
