import 'package:gmsflutter/entity/purchase_part/item.dart';

class StockOut {
  int? id;
  String? transactionDate;
  int? quantity;
  Item? item;

  StockOut({this.id, this.transactionDate, this.quantity, this.item});

  factory StockOut.fromJson(Map<String, dynamic> json) {
    return StockOut(
      id: json['id'],
      transactionDate: json['transactionDate'],
      quantity: json['quantity'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionDate': transactionDate,
      'quantity': quantity,
      'item': item?.toJson(),
    };
  }
}