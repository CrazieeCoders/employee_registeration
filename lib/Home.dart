import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:path/path.dart' as Path;

import 'DB/Services.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  TextEditingController _empCodeTextController = TextEditingController();
  TextEditingController _empNameTextController = TextEditingController();
  TextEditingController _empAddr1TextController = TextEditingController();
  TextEditingController _empAddr2Controller = TextEditingController();
  TextEditingController _mobileNumberTextController = TextEditingController();
  TextEditingController _dateOfBirthTextController = TextEditingController();
  TextEditingController _remarksTextController = TextEditingController();

  int min = 100000;
  int max = 999999;
  var randoMiser = new Random();
  var empCode;
  String _date;

  final Color bgColor = Colors.pink;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    empCode = min + randoMiser.nextInt(max-min);
    _empCodeTextController.text =  "$empCode";
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: new AppBar(
        title: new Text('Registeration'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        child: Card(
          elevation: 2.0,
          child: Container(
            color: Colors.white70,
            child: Column(
              children: <Widget>[

                SizedBox(
                  height: 20.0,
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _empCodeTextController,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.confirmation_number,
                            color: Colors.pink,),
                            hintText: 'Enter Employee Code',
                            labelText: 'Employee Code',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Employee Name cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _empNameTextController,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.person_outline,
                            color: Colors.pink,),
                            hintText: 'Enter Employee Name',
                            labelText: 'Employee Name',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Employee Name cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _empAddr1TextController,
                          decoration:  InputDecoration(
                            icon: const Icon(Icons.description,
                            color: Colors.pink,),
                            hintText: 'Enter Address Line 1 ',
                            labelText: 'addressline 1',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Addressline 1 cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _empAddr2Controller,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.description,
                            color: Colors.pink,),
                            hintText: 'Enter Address Line 2 ',
                            labelText: 'AddressLine 2',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter AddressLine 2';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _mobileNumberTextController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.phone,
                            color: Colors.pink,),
                            hintText: 'Enter Mobile Number ',
                            labelText: 'Mobile Number',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Mobile Number';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _dateOfBirthTextController,
                          onTap: ()async{
                            FocusScope.of(context).requestFocus(new FocusNode());
                            DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: new DateTime.now(),
                                firstDate: new DateTime(1960),
                                lastDate: new DateTime.now()
                            );
                            if(picked != null) {

                              setState(() {
                                _dateOfBirthTextController.value = TextEditingValue(text: picked.toString().substring(0,10));
                              });
                            };
                          },

                          decoration: const InputDecoration(
                            icon: const Icon(Icons.date_range,
                            color: Colors.pink,),
                            hintText: 'Enter date of Birth ',
                            labelText: 'dateOfBirth',
                          ),

                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter DateOfBirth';
                            }
                            return null;
                          },

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _remarksTextController,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.inbox,
                            color: Colors.pink,),
                            hintText: 'Enter Remarks ',
                            labelText: 'Remarks',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Remarks';
                            }
                            return null;
                          },
                        ),
                      ),

                    ],
                  ),
                ),



                Row(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: new RaisedButton(
                          color: Colors.pink,
                          child: const Text('save',
                          style: TextStyle(
                            color: Colors.white
                          ),),
                          onPressed: () async {
                           _addEmployee();

                          },
                        )),
                    Container(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: new RaisedButton(
                          color: Colors.pink,
                          child: const Text('delete',
                          style: TextStyle(
                            color: Colors.white
                          ),),
                          onPressed: () async {
                            _deleteEmployee();
                          },
                        )),
                    Container(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: new RaisedButton(
                          color: Colors.pink,
                          child: const Text('modify',
                          style: TextStyle(
                            color: Colors.white
                          ),),
                          onPressed: () async {
                            _updateEmployee();
                          },
                        )),
                    Container(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: new RaisedButton(
                          color: Colors.pink,
                          child: const Text('print',
                          style: TextStyle(color: Colors.white),),
                          onPressed: () async {
                            _showsnackBar("Moved to Printer");
                          },
                        )),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),

          ),
        ),
      ),

    );
  }


  _showsnackBar(String msg){
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 1)
    ));
  }
  _createTable(){

    Services.createTable().then((result){
      if('success' == result){
        print('table creation success');
        _showsnackBar("Table Creation success");
      }

    });

  }

   _addEmployee(){

    FormState formState = _formKey.currentState;

    if(formState.validate()){


        Services.addEmployee(_empCodeTextController.text, _empNameTextController.text, _empAddr1TextController.text,
            _empAddr2Controller.text, _mobileNumberTextController.text, _dateOfBirthTextController.text,
            _remarksTextController.text).then((result){


              if('success' == result){
                print('Add Employee Success');
                _showsnackBar("Employee Added");
              }
        });



    }

   }





   _deleteEmployee(){

     FormState formState = _formKey.currentState;


           if(_empCodeTextController.text != null || _empCodeTextController.text != '') {
             print(_empCodeTextController.text);

             Services.deleteEmployee(_empCodeTextController.text).then((
                 result) {
               if ('success' == result) {
                 print('Delete employee Success');
                 _showsnackBar("Empoyee Deleted");
               }
             });
           }




   }

  _updateEmployee(){
    FormState formState = _formKey.currentState;


    if(_empCodeTextController.text != null || _empCodeTextController.text != '') {
      print(_empCodeTextController.text);

      Services.updateEmployee(_empCodeTextController.text, _empNameTextController.text, _empAddr1TextController.text
          , _empAddr2Controller.text, _mobileNumberTextController.text,
          _dateOfBirthTextController.text, _remarksTextController.text).then((result){

        if('success' == result){
          print('Update Employe Success');
          _showsnackBar("Employee Updated");
        }
      });



    }
  }

}

