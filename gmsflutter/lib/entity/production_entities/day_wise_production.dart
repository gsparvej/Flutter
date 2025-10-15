import 'package:gmsflutter/entity/merchandiser_part/order.dart';
import 'package:gmsflutter/entity/production_entities/production_order.dart';

class DayWiseProduction {
  int? id;
  String? updatedDate;
  int? shortSQty;
  int? shortMQty;
  int? shortLQty;
  int? shortXLQty;
  int? fullSQty;
  int? fullMQty;
  int? fullLQty;
  int? fullXLQty;
  Order? order;
  ProductionOrder? productionOrder;

  DayWiseProduction({this.id, this.updatedDate, this.shortSQty, this.shortMQty, this.shortLQty, this.shortXLQty, this.fullSQty, this.fullMQty, this.fullLQty, this.fullXLQty, this.order, this.productionOrder});

  factory DayWiseProduction.fromJson(Map<String, dynamic> json) {
    return DayWiseProduction(
      id: json['id'],
      updatedDate: json['updatedDate'],
      shortSQty: json['shortSQty'],
      shortMQty: json['shortMQty'],
      shortLQty: json['shortLQty'],
      shortXLQty: json['shortXLQty'],
      fullSQty: json['fullSQty'],
      fullMQty: json['fullMQty'],
      fullLQty: json['fullLQty'],
      fullXLQty: json['fullXLQty'],
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      productionOrder: json['productionOrder'] != null ? ProductionOrder.fromJson(json['productionOrder']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'updatedDate': updatedDate,
      'shortSQty': shortSQty,
      'shortMQty': shortMQty,
      'shortLQty': shortLQty,
      'shortXLQty': shortXLQty,
      'fullSQty': fullSQty,
      'fullMQty': fullMQty,
      'fullLQty': fullLQty,
      'fullXLQty': fullXLQty,
      'order': order?.toJson(),
      'productionOrder': productionOrder?.toJson(),
    };
  }
}