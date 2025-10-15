import 'package:gmsflutter/entity/merchandiser_part/bom_style.dart';
import 'package:gmsflutter/entity/merchandiser_part/order.dart';

class RawMaterialsCheck {
  int? id;
  int? shortSTotalQuantity;
  int? shortMTotalQuantity;
  int? shortLTotalQuantity;
  int? shortXLTotalQuantity;
  int? fullSTotalQuantity;
  int? fullMTotalQuantity;
  int? fullLTotalQuantity;
  int? fullXLTotalQuantity;
  double? totalFabric;
  Order? order;
  BomStyle? bomStyle;

  RawMaterialsCheck({this.id, this.shortSTotalQuantity, this.shortMTotalQuantity, this.shortLTotalQuantity, this.shortXLTotalQuantity, this.fullSTotalQuantity, this.fullMTotalQuantity, this.fullLTotalQuantity, this.fullXLTotalQuantity, this.totalFabric, this.order, this.bomStyle});

  factory RawMaterialsCheck.fromJson(Map<String, dynamic> json) {
    return RawMaterialsCheck(
      id: json['id'],
      shortSTotalQuantity: json['shortSTotalQuantity'],
      shortMTotalQuantity: json['shortMTotalQuantity'],
      shortLTotalQuantity: json['shortLTotalQuantity'],
      shortXLTotalQuantity: json['shortXLTotalQuantity'],
      fullSTotalQuantity: json['fullSTotalQuantity'],
      fullMTotalQuantity: json['fullMTotalQuantity'],
      fullLTotalQuantity: json['fullLTotalQuantity'],
      fullXLTotalQuantity: json['fullXLTotalQuantity'],
      totalFabric: json['totalFabric'],
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      bomStyle: json['bomStyle'] != null ? BomStyle.fromJson(json['bomStyle']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shortSTotalQuantity': shortSTotalQuantity,
      'shortMTotalQuantity': shortMTotalQuantity,
      'shortLTotalQuantity': shortLTotalQuantity,
      'shortXLTotalQuantity': shortXLTotalQuantity,
      'fullSTotalQuantity': fullSTotalQuantity,
      'fullMTotalQuantity': fullMTotalQuantity,
      'fullLTotalQuantity': fullLTotalQuantity,
      'fullXLTotalQuantity': fullXLTotalQuantity,
      'totalFabric': totalFabric,
      'order': order?.toJson(),
      'bomStyle': bomStyle?.toJson(),
    };
  }
}