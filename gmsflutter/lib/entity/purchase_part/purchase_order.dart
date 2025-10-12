import 'package:gmsflutter/entity/purchase_part/item.dart';
import 'package:gmsflutter/entity/purchase_part/vendor.dart';

class PurchaseOrder {
  int? id;
  String? poNumber;
  String? poDate;
  int? quantity;
  int? rate;
  int? subTotal;
  int? totalAmount;
  int? tax;
  String? deliveryDate;
  String? termsAndCondition;
  Vendor? vendor;
  Item? item;

  PurchaseOrder(
      {this.id,
        this.poNumber,
        this.poDate,
        this.quantity,
        this.rate,
        this.subTotal,
        this.totalAmount,
        this.tax,
        this.deliveryDate,
        this.termsAndCondition,
        this.vendor,
        this.item});

  PurchaseOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    poNumber = json['poNumber'];
    poDate = json['poDate'];
    quantity = json['quantity'];
    rate = json['rate'];
    subTotal = json['subTotal'];
    totalAmount = json['totalAmount'];
    tax = json['tax'];
    deliveryDate = json['deliveryDate'];
    termsAndCondition = json['termsAndCondition'];
    vendor =
    json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['poNumber'] = this.poNumber;
    data['poDate'] = this.poDate;
    data['quantity'] = this.quantity;
    data['rate'] = this.rate;
    data['subTotal'] = this.subTotal;
    data['totalAmount'] = this.totalAmount;
    data['tax'] = this.tax;
    data['deliveryDate'] = this.deliveryDate;
    data['termsAndCondition'] = this.termsAndCondition;
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}