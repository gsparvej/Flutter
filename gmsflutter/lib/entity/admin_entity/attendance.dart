import 'package:gmsflutter/entity/admin_entity/employee.dart';

class Attendance {
  int? id;
  String? attDate;
  String? status;
  Employee? employee;

  Attendance({this.id, this.attDate, this.status, this.employee});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      attDate: json['attDate'],
      status: json['status'],
      employee: json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attDate': attDate,
      'status': status,
      'employee': employee?.toJson(),
    };
  }
}