class Employee {
  Employee({
  this.employeeCode,
  this.employeeName,
  this.addr1,
  this.addr2,
  this.phoneNumber,
  this.date,
  this.remarks,
  });

  String employeeCode;
  String employeeName;
  String addr1;
  String addr2;
  String phoneNumber;
  DateTime date;
  String remarks;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
  employeeCode: json["employee_code"],
  employeeName: json["employee_name"],
  addr1: json["addr1"],
  addr2: json["addr2"],
  phoneNumber: json["phone_number"],
  date: DateTime.parse(json["date"]),
  remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
  "employee_code": employeeCode,
  "employee_name": employeeName,
  "addr1": addr1,
  "addr2": addr2,
  "phone_number": phoneNumber,
  "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  "remarks": remarks,
  };
  }






