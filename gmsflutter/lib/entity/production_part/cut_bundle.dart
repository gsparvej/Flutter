class CutBundle {
  String bundleNo;
  String color;
  int plannedQty;
  String size;
  String cutBundleDate;
  int cuttingPlanId; // store only the ID

  CutBundle({
    required this.bundleNo,
    required this.color,
    required this.plannedQty,
    required this.size,
    required this.cutBundleDate,
    required this.cuttingPlanId,
  });

  Map<String, dynamic> toJson() {
    return {
      'bundleNo': bundleNo,
      'color': color,
      'plannedQty': plannedQty,
      'size': size,
      'cutBundleDate': cutBundleDate,
      'cuttingPlan': {'id': cuttingPlanId}, // nested object like Angular
    };
  }
  factory CutBundle.fromJson(Map<String, dynamic> json) {
    return CutBundle(
      bundleNo: json['bundleNo'],
      color: json['color'],
      plannedQty: json['plannedQty'],
      size: json['size'],
      cutBundleDate: json['cutBundleDate'],
      cuttingPlanId: json['cuttingPlan']?['id'] ?? 0, // ✅ FIXED
    );
  }

}