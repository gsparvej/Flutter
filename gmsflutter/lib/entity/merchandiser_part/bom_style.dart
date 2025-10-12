class BomStyle {
  int? id;
  String? styleCode;
  String? styleType;
  String? description;

  BomStyle({this.id, this.styleCode, this.styleType, this.description});

  BomStyle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    styleCode = json['styleCode'];
    styleType = json['styleType'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['styleCode'] = this.styleCode;
    data['styleType'] = this.styleType;
    data['description'] = this.description;
    return data;
  }
}