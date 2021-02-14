import "package:flutter/material.dart";
import 'package:homeservice/AddServiceScreens/Service_Carpet.dart';
import 'package:homeservice/AddServiceScreens/Service_Grass.dart';
import 'package:homeservice/AddServiceScreens/Service_HomeCleaning.dart';
import 'package:homeservice/AddServiceScreens/Service_Paint.dart';
import 'package:homeservice/AddServiceScreens/Service_Sanitize.dart';
import 'package:homeservice/AddServiceScreens/Service_Vacuum.dart';
import 'package:homeservice/AddServiceScreens/Service_Window.dart';
import 'package:homeservice/AddServiceScreens/Service_Wiring.dart';
import 'package:homeservice/HomeCleaning.dart';
import 'package:homeservice/screens/CarpetCleaning.dart';
import 'package:homeservice/screens/Grass%20Cutting.dart';
import 'package:homeservice/screens/HomeSanitize.dart';
import 'package:homeservice/screens/PaintJob.dart';
import 'package:homeservice/screens/Vacuuming.dart';
import 'package:homeservice/screens/WindowCleaning.dart';

class ServiceMain extends StatelessWidget {

  var services = [
    "House Cleaning Service",
    "Carpet Cleaning Service",
    "Grass Cutting Service",
    "Paint job Service",
    "Home Sanitization Service",
    "Vacuuming Service",
    "Window Cleaning Service",
    "Wiring Service",
  ];

  var images = [
    "image/broom.jpg",
    "image/carpet.jpg",
    "image/grass.png",
    "image/paint.png",
    "image/sanitizer.png",
    "image/vacuum.png",
    "image/window.png",
    "image/wiring.png",
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'What service do you want to add?'),
         backgroundColor: Colors.deepOrange,
        ),

        body: Padding(
          padding: EdgeInsets.all(8),
          child: GridView.builder(
              itemCount: services.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/2)
              ),
              itemBuilder: (BuildContext context,int index){
                return Card(
                    child: InkWell(
                      onTap: (){
                        if (services[index] == "House Cleaning Service") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServiceHomeCleaning()),
                          );
                        } else if (services[index] == "Carpet Cleaning Service") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServiceCarpet()),
                          );
                        }else if (services[index] == "Grass Cutting Service") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServiceGrass()),
                          );
                        }else if (services[index] == "Paint job Service") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServicePaint()),
                          );
                        }else if (services[index] == "Home Sanitization Service") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServiceSanitize()),
                          );
                        }else if (services[index] == "Vacuuming Service") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServiceVacuum()),
                          );
                        }else if (services[index] == "Window Cleaning Service") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServiceWindow()),
                          );
                        }else if (services[index] == "Wiring Service") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServiceWiring()),
                          );
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(images[index],height: 40,width: 50,),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(services[index],style: TextStyle(fontSize: 16,height: 1.2,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ),


                        ],
                      ),

                    ))
                ;


              }
          ),
        ));
  }
}