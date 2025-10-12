class RequisitionList {
  int? id;
  String? prDate;
  String? requestedBy;
  String? prStatus;

  RequisitionList({this.id, this.prDate, this.requestedBy, this.prStatus});

  RequisitionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prDate = json['prDate'];
    requestedBy = json['requestedBy'];
    prStatus = json['prStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prDate'] = this.prDate;
    data['requestedBy'] = this.requestedBy;
    data['prStatus'] = this.prStatus;
    return data;
  }
}
