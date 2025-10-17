import 'package:gmsflutter/entity/purchase_part/item.dart';

class StockIn {
  int? id;
  String? receivedTransactionDate;
  int? quantity;
  Item? item;

  StockIn({this.id, this.receivedTransactionDate, this.quantity, this.item});

  factory StockIn.fromJson(Map<String, dynamic> json) {
    return StockIn(
      id: json['id'],
      receivedTransactionDate: json['receivedTransactionDate'],
      quantity: json['quantity'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receivedTransactionDate': receivedTransactionDate,
      'quantity': quantity,
      'item': item?.toJson(),
    };
  }
}