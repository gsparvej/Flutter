class Uom {
  Uom({
    required this.id,
    required this.productName,
    required this.size,
    required this.body,
    required this.sleeve,
    required this.pocket,
    required this.wastage,
    required this.shrinkage,
    required this.baseFabric,
  });

  final int? id;
  final String? productName;
  final String? size;
  final double? body;
  final double? sleeve;
  final double? pocket;
  final double? wastage;
  final double? shrinkage;
  final double? baseFabric;

  factory Uom.fromJson(Map<String, dynamic> json){
    return Uom(
      id: json["id"],
      productName: json["productName"],
      size: json["size"],
      body: json["body"],
      sleeve: json["sleeve"],
      pocket: json["pocket"],
      wastage: json["wastage"],
      shrinkage: json["shrinkage"],
      baseFabric: json["baseFabric"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "productName": productName,
    "size": size,
    "body": body,
    "sleeve": sleeve,
    "pocket": pocket,
    "wastage": wastage,
    "shrinkage": shrinkage,
    "baseFabric": baseFabric,
  };

}
