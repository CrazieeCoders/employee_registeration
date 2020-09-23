import 'package:employee_master/model/Employee.dart';
import 'package:flutter/material.dart';

import 'DB/Services.dart';



class EmployeeTable extends StatefulWidget {
  @override
  _EmployeeTableState createState() => _EmployeeTableState();
}

class _EmployeeTableState extends State<EmployeeTable> {

  List<Employee> _employees;
  // this list will hold the filtered employees

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _employees = [];
  }

  _getEmployees() {
    print("Get Employee Function called");
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
        // Initialize to the list from Server when reloading...
      });

      print('$employees');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table contents'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: GestureDetector(
              onTap: _getEmployees,
              child: new Icon(Icons.refresh,
              color: Colors.white,),
            ),
            highlightColor: Colors.white,
          ),
        ],
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(
                label: Text('Employee Code'),
              ),
              DataColumn(
                label: Text('Employee Name'),
              ),
              DataColumn(
                label: Text('Addr1'),
              ),
              DataColumn(
                label: Text('Addr2'),
              ),
              DataColumn(
                label: Text('Phonenumber'),
              ),
              DataColumn(
                label: Text('DateOfBirth'),
              ),
              DataColumn(
                label: Text('Remarks'),
              ),
              // Lets add one more column to show a delete button
            ],
            // the list should show the filtered list now
            rows: _employees
                .map(
                  (employee) => DataRow(cells: [
                DataCell(
                  Text(employee.employeeCode),
                  // Add tap in the row and populate the
                  // textfields with the corresponding values to update

                ),
                DataCell(
                  Text(
                    employee.employeeName,
                  ),

                ),
                DataCell(
                  Text(
                    employee.addr1,
                  ),
                ),
                    DataCell(
                      Text(employee.addr2),
                      // Add tap in the row and populate the
                      // textfields with the corresponding values to update

                    ),
                    DataCell(
                      Text(
                        employee.phoneNumber,
                      ),

                    ),
                    DataCell(
                      Text(
                        employee.date.toString().substring(0,10),
                      ),
                    ),
                    DataCell(
                      Text(
                        employee.remarks,
                      ),
                    ),
                  ]),
            )
                .toList(),
          ),
        ),
      ),
    );
  }
}
