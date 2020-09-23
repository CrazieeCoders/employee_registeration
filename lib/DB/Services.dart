import 'dart:convert';
import 'package:employee_master/model/Employee.dart';
import 'package:http/http.dart'
as http;


class Services{

  static const ROOT ='https://flutterdatabasejagan.000webhostapp.com/employee_storedProcedure.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

   static Future<String> createTable() async{

      try{

        var map = Map<String,dynamic>();
        map['action']= _CREATE_TABLE_ACTION;
        final response = await http.post(ROOT,body: map);
        print('Create Table Response: ${response.body}');

        if(200 == response.statusCode){
             return response.body;
        }else{
              return "error";
        }
      }catch(e){
        return "error";
      }


   }

   static Future<String> addEmployee(String empID,String empName,String addr1,String addr2,String phonenumber
       ,String dob,String remarks) async{

     try{

       var map =Map<String,dynamic> ();
       map['action'] = _ADD_EMP_ACTION;
       map['empID'] = empID;
       map['empName'] = empName;
       map['addr1'] = addr1;
       map['addr2'] = addr2;
       map['phonenumber'] = phonenumber;
       map['dob'] = dob;
       map['remarks'] = remarks;

       final response = await http.post(ROOT,body: map);
       print('addEmploye Response: $response.body');

       if(200 == response.statusCode){
           return "success";
       }else{
          return "error";
       }

     }catch(e){
       return "error";
     }
   }

    static Future<String>  deleteEmployee(String empId) async{

       try{

         var map =Map<String,dynamic>();
         map['action']=_DELETE_EMP_ACTION;
         map['empID'] = empId;

         final response = await http.post(ROOT,body: map);
         print('Delete Employee:$response.body');

         if(200 == response.statusCode){
           return "success";
         }else{
           return "error";
         }

       }catch(e){
           return "error";
       }
    }


  static Future<String> updateEmployee(String empId,String empName,String addr1,String addr2,String phoneNumber,String dob,String remarks) async{

     try{
       var map = Map<String,dynamic>();
       map['action'] = _UPDATE_EMP_ACTION;
       map['empID'] = empId;
       map['empName'] = empName;
       map['addr1'] = addr1;
       map['addr2'] = addr2;
       map['phonenumber'] = phoneNumber;
       map['dob'] = dob;
       map['remarks'] = remarks;


        final response = await http.post(ROOT,body: map);
        
        print('update employee Response: ${response.body}');

        if(200 == response.statusCode){
          return "success";
        }else{
          return "error";
        }


     }catch(e){
       return "error";
     }


  }

  static Future<List<Employee>> getEmployees() async{

     try{
         var map = Map<String,dynamic>();

         map['action'] = _GET_ALL_ACTION;
         final response = await http.post(ROOT,body: map);
         print('getEmployee Response: ${response.body}');

         print("hello");
         print(response.statusCode);
         if(200 == response.statusCode){
           print("Came inside if condition");
           String result = response.body;
          List<Employee> list = parseResponse(response.body.substring(22,result.length));


           return list;
         }else {
           print("else statement");
           return List<Employee>();
         }
     }catch (e){

       return List<Employee>();
     }
  }

  static List<Employee> parseResponse(String responseBody) {

   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }




}

