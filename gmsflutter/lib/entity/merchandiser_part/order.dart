import 'package:gmsflutter/entity/merchandiser_part/bom_style.dart';
import 'package:gmsflutter/entity/merchandiser_part/buyer.dart';

class Order {
  int? id;
  String? orderDate;
  String? deliveryDate;
  int? shortSmallSize;
  int? shortSPrice;
  int? shortMediumSize;
  int? shortMPrice;
  int? shortLargeSize;
  int? shortLPrice;
  int? shortXLSize;
  int? shortXLPrice;
  int? fullSmallSize;
  int? fullSPrice;
  int? fullMediumSize;
  int? fullMPrice;
  int? fullLargeSize;
  int? fullLPrice;
  int? fullXLSize;
  int? fullXLPrice;
  int? subTotal;
  int? vat;
  int? paidAmount;
  int? dueAmount;
  int? total;
  String? remarks;
  String? orderStatus;
  BomStyle? bomStyle;
  Buyer? buyer;

  Order(
      {this.id,
        this.orderDate,
        this.deliveryDate,
        this.shortSmallSize,
        this.shortSPrice,
        this.shortMediumSize,
        this.shortMPrice,
        this.shortLargeSize,
        this.shortLPrice,
        this.shortXLSize,
        this.shortXLPrice,
        this.fullSmallSize,
        this.fullSPrice,
        this.fullMediumSize,
        this.fullMPrice,
        this.fullLargeSize,
        this.fullLPrice,
        this.fullXLSize,
        this.fullXLPrice,
        this.subTotal,
        this.vat,
        this.paidAmount,
        this.dueAmount,
        this.total,
        this.remarks,
        this.orderStatus,
        this.bomStyle,
        this.buyer});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDate = json['orderDate'];
    deliveryDate = json['deliveryDate'];
    shortSmallSize = json['shortSmallSize'];
    shortSPrice = json['shortSPrice'];
    shortMediumSize = json['shortMediumSize'];
    shortMPrice = json['shortMPrice'];
    shortLargeSize = json['shortLargeSize'];
    shortLPrice = json['shortLPrice'];
    shortXLSize = json['shortXLSize'];
    shortXLPrice = json['shortXLPrice'];
    fullSmallSize = json['fullSmallSize'];
    fullSPrice = json['fullSPrice'];
    fullMediumSize = json['fullMediumSize'];
    fullMPrice = json['fullMPrice'];
    fullLargeSize = json['fullLargeSize'];
    fullLPrice = json['fullLPrice'];
    fullXLSize = json['fullXLSize'];
    fullXLPrice = json['fullXLPrice'];
    subTotal = json['subTotal'];
    vat = json['vat'];
    paidAmount = json['paidAmount'];
    dueAmount = json['dueAmount'];
    total = json['total'];
    remarks = json['remarks'];
    orderStatus = json['orderStatus'];
    bomStyle = json['bomStyle'] != null
        ? new BomStyle.fromJson(json['bomStyle'])
        : null;
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderDate'] = this.orderDate;
    data['deliveryDate'] = this.deliveryDate;
    data['shortSmallSize'] = this.shortSmallSize;
    data['shortSPrice'] = this.shortSPrice;
    data['shortMediumSize'] = this.shortMediumSize;
    data['shortMPrice'] = this.shortMPrice;
    data['shortLargeSize'] = this.shortLargeSize;
    data['shortLPrice'] = this.shortLPrice;
    data['shortXLSize'] = this.shortXLSize;
    data['shortXLPrice'] = this.shortXLPrice;
    data['fullSmallSize'] = this.fullSmallSize;
    data['fullSPrice'] = this.fullSPrice;
    data['fullMediumSize'] = this.fullMediumSize;
    data['fullMPrice'] = this.fullMPrice;
    data['fullLargeSize'] = this.fullLargeSize;
    data['fullLPrice'] = this.fullLPrice;
    data['fullXLSize'] = this.fullXLSize;
    data['fullXLPrice'] = this.fullXLPrice;
    data['subTotal'] = this.subTotal;
    data['vat'] = this.vat;
    data['paidAmount'] = this.paidAmount;
    data['dueAmount'] = this.dueAmount;
    data['total'] = this.total;
    data['remarks'] = this.remarks;
    data['orderStatus'] = this.orderStatus;
    if (this.bomStyle != null) {
      data['bomStyle'] = this.bomStyle!.toJson();
    }
    if (this.buyer != null) {
      data['buyer'] = this.buyer!.toJson();
    }
    return data;
  }
}