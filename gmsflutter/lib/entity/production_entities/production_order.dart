import 'package:gmsflutter/entity/merchandiser_part/bom_style.dart';
import 'package:gmsflutter/entity/merchandiser_part/order.dart';

class ProductionOrder {
  int? id;
  int? planQty;
  String? startDate;
  String? endDate;
  String? priority;
  String? status;
  String? description;
  String? size;
  BomStyle? bomStyle;
  Order? order;

  ProductionOrder({this.id, this.planQty, this.startDate, this.endDate, this.priority, this.status, this.description, this.size, this.bomStyle, this.order});

  factory ProductionOrder.fromJson(Map<String, dynamic> json) {
    return ProductionOrder(
      id: json['id'],
      planQty: json['planQty'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      priority: json['priority'],
      status: json['status'],
      description: json['description'],
      size: json['size'],
      bomStyle: json['bomStyle'] != null ? BomStyle.fromJson(json['bomStyle']) : null,
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'planQty': planQty,
      'startDate': startDate,
      'endDate': endDate,
      'priority': priority,
      'status': status,
      'description': description,
      'size': size,
      'bomStyle': bomStyle?.toJson(),
      'order': order?.toJson(),
    };
  }
}