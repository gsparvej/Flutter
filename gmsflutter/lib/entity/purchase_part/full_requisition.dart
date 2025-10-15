import 'package:gmsflutter/entity/admin_entity/department.dart';
import 'package:gmsflutter/entity/merchandiser_part/order.dart';
import 'package:gmsflutter/entity/purchase_part/item.dart';

class FullRequisition {
  int? id;
  String? prDate;
  String? requestedBy;
  int? quantity;
  int? approxUnitPrice;
  int? totalEstPrice;
  String? prStatus;
  Order? order;
  Item? item;
  Department? department;

  FullRequisition(
      {this.id,
        this.prDate,
        this.requestedBy,
        this.quantity,
        this.approxUnitPrice,
        this.totalEstPrice,
        this.prStatus,
        this.order,
        this.item,
        this.department});

  FullRequisition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prDate = json['prDate'];
    requestedBy = json['requestedBy'];
    quantity = json['quantity'];
    approxUnitPrice = json['approxUnitPrice'];
    totalEstPrice = json['totalEstPrice'];
    prStatus = json['prStatus'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prDate'] = this.prDate;
    data['requestedBy'] = this.requestedBy;
    data['quantity'] = this.quantity;
    data['approxUnitPrice'] = this.approxUnitPrice;
    data['totalEstPrice'] = this.totalEstPrice;
    data['prStatus'] = this.prStatus;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    return data;
  }
}