import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeservice/MainPage.dart';
import 'package:homeservice/ServiceProvider/MainPageServiceProvider.dart';
import 'package:homeservice/authenticationservice.dart';
import 'package:homeservice/home.dart';
import 'package:provider/provider.dart';

class ServiceCarpet extends StatefulWidget {
  @override
  _ServiceCarpetState createState() => _ServiceCarpetState();
}

class _ServiceCarpetState extends State<ServiceCarpet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Carpet Cleaning'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Enter Your Service Information',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),),
                  labelText: 'Company Name',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Company name is empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: districtController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),),
                  labelText: 'District',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'District is empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: rateController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),),
                  labelText: 'Rate per hour',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Rate is empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                maxLines: 10,
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Description of the service",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.deepOrange,
                  child: Text('Add Service'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      context.read<AuthenticationService>().addCarpet(
                        title: titleController.text,
                        district: districtController.text,
                        rate: rateController.text,
                        description: descriptionController.text,
                      );
                      showAlertDialog(context);
                      // TODO submit
                    }
                  },
                )
            ),
          ],
        ),
      ),
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
          builder: (context) => MainPageService(),
        ),); },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Text("You are successfully added a service!"),
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


