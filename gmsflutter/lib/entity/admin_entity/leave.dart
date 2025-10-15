import 'package:gmsflutter/entity/admin_entity/employee.dart';

class Leave {
  int? id;
  String? leaveType;
  String? fromDate;
  String? toDate;
  String? status;
  Employee? employee;

  Leave({this.id, this.leaveType, this.fromDate, this.toDate, this.status, this.employee});

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      id: json['id'],
      leaveType: json['leaveType'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      status: json['status'],
      employee: json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leaveType': leaveType,
      'fromDate': fromDate,
      'toDate': toDate,
      'status': status,
      'employee': employee?.toJson(),
    };
  }
}