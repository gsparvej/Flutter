import 'package:gmsflutter/entity/admin_entity/department.dart';

class Designation {
  int? id;
  String? designationTitle;
  Department? department;

  Designation({this.id, this.designationTitle, this.department});

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      id: json['id'],
      designationTitle: json['designationTitle'],
      department: json['department'] != null ? Department.fromJson(json['department']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'designationTitle': designationTitle,
      'department': department?.toJson(),
    };
  }
}