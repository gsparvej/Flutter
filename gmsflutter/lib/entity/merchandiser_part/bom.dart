import 'package:gmsflutter/entity/merchandiser_part/bom_style.dart';
import 'package:gmsflutter/entity/merchandiser_part/uom.dart';

class BOM {
  int? id;
  int? serial;
  String? material;
  String? unit;
  int? quantity;
  int? unitPrice;
  int? totalCost;
  Uom? uom;
  BomStyle? bomStyle;

  BOM({this.id, this.serial, this.material, this.unit, this.quantity, this.unitPrice, this.totalCost, this.uom, this.bomStyle});

  factory BOM.fromJson(Map<String, dynamic> json) {
    return BOM(
      id: json['id'],
      serial: json['serial'],
      material: json['material'],
      unit: json['unit'],
      quantity: (json['quantity'] as num?)?.toInt(),
      unitPrice: (json['unitPrice'] as num?)?.toInt(),
      totalCost: (json['totalCost'] as num?)?.toInt(),
      uom: json['uom'] != null ? Uom.fromJson(json['uom']) : null,
      bomStyle: json['bomStyle'] != null ? BomStyle.fromJson(json['bomStyle']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serial': serial,
      'material': material,
      'unit': unit,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalCost': totalCost,
      'uom': uom?.toJson(),
      'bomStyle': bomStyle?.toJson(),
    };
  }
}