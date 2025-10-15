class Line {
  int? id;
  String? lineCode;
  String? floor;
  int? capacityPerHour;

  Line({this.id, this.lineCode, this.floor, this.capacityPerHour});

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      id: json['id'],
      lineCode: json['lineCode'],
      floor: json['floor'],
      capacityPerHour: json['capacityPerHour'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lineCode': lineCode,
      'floor': floor,
      'capacityPerHour': capacityPerHour,
    };
  }
}