import 'package:gmsflutter/entity/admin_entity/department.dart';
import 'package:gmsflutter/entity/admin_entity/designation.dart';

class Employee {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? joinDate;
  Designation? designation;
  Department? department;

  Employee({this.id, this.name, this.phoneNumber, this.email, this.joinDate, this.designation, this.department});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      joinDate: json['joinDate'],
      designation: json['designation'] != null ? Designation.fromJson(json['designation']) : null,
      department: json['department'] != null ? Department.fromJson(json['department']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'joinDate': joinDate,
      'designation': designation?.toJson(),
      'department': department?.toJson(),
    };
  }
}