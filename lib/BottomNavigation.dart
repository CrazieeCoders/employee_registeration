import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'table.dart';
import 'home.dart';

class MainPage extends StatefulWidget {


  @override
  _mainState createState() => _mainState();
}

class _mainState extends State<MainPage> {

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();


  Widget moveSlide(int _currentIndex){


    switch (_currentIndex){

      case 0:return Home();
      case 1:return EmployeeTable();
      break;
      default:return Home();


    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: moveSlide(_page),

      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.pink,
        backgroundColor:Colors.pink.withOpacity(0.7),
        // buttonBackgroundColor:Colors.amber ,
        buttonBackgroundColor:Colors.pink.withOpacity(0.7),
        height: 60,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.tab, size: 30),
        ],
        animationDuration: Duration(
            milliseconds: 200
        ),
        index: 0,
        animationCurve: Curves.bounceInOut,
        onTap: (index){
          _page = index;
          setState(() {

          });
        },

      ),


    );
  }
}
