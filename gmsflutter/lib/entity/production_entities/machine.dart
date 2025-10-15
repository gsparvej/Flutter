class Machine {
  int? id;
  String? machineCode;
  String? status;

  Machine({this.id, this.machineCode, this.status});

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      id: json['id'],
      machineCode: json['machineCode'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'machineCode': machineCode,
      'status': status,
    };
  }
}